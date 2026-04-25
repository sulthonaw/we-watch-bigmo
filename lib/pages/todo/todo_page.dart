import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:narabuna/pages/todo/todo_view_model.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthState>().token;
      if (token != null) {
        context.read<TodoViewModel>().fetchTodos(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);

    final todoVm = context.watch<TodoViewModel>();
    final authState = context.read<AuthState>();

    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: const BottomNavbarCustom(currentIndex: 3),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DAFTAR TUGAS',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Persiapan persalinan Bunda',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/maskots/safe.png', height: 60),
                  ],
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: todoVm.progress,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Progress Persiapan',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(todoVm.progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: todoVm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: primaryGreen),
                  )
                : todoVm.todos.isEmpty
                ? const Center(child: Text('Belum ada tugas saat ini.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    itemCount: todoVm.todos.length,
                    itemBuilder: (context, index) {
                      final item = todoVm.todos[index];
                      return _buildTodoCard(
                        context,
                        item,
                        authState.token!,
                        todoVm,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoCard(
    BuildContext context,
    dynamic item,
    String token,
    TodoViewModel vm,
  ) {
    final bool isDone = item['status'] ?? false;
    const Color primaryGreen = Color(0xFF537C57);

    return GestureDetector(
      onTap: () => vm.toggleTodoStatus(token, item['id'], isDone),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDone ? primaryGreen.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? primaryGreen : Colors.transparent,
                border: Border.all(
                  color: isDone ? primaryGreen : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item['keterangan'] ?? '',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 15,
                  color: isDone ? Colors.grey[400] : Colors.black87,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
