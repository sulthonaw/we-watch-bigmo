import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:narabuna/pages/kondisi/kondisi_view_model.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:narabuna/auth/auth_state.dart';

class KondisiPage extends StatefulWidget {
  const KondisiPage({super.key});

  @override
  State<KondisiPage> createState() => _KondisiPageState();
}

class _KondisiPageState extends State<KondisiPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthState>().token;
      if (token != null) {
        context.read<KondisiViewModel>().fetchConditions(token);
      }
    });
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    final viewModel = context.watch<KondisiViewModel>();
    final progress = viewModel.data?['pregnancyProgress']?.toDouble() ?? 0.0;
    final visits = (viewModel.data?['visits'] as List?) ?? [];

    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: const BottomNavbarCustom(currentIndex: 1),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryGreen))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                        child: const Text(
                          'Kondisi',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 150,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: primaryGreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.local_florist,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Progres Kehamilan',
                                      style: TextStyle(
                                        fontFamily: 'SFProDisplay',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${(progress / 100 * 40).toInt()} / 40 minggu',
                                    style: TextStyle(
                                      fontFamily: 'SFProDisplay',
                                      fontSize: 13,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Stack(
                                children: [
                                  Container(
                                    height: 35,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF2F4EE),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: progress / 100,
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: primaryGreen,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        '${progress.toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          fontFamily: 'SFProDisplay',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildTrimesterSection('TRIMESTER 1', visits, 'TRIMESTER_1'),
                  _buildTrimesterSection('TRIMESTER 2', visits, 'TRIMESTER_2'),
                  _buildTrimesterSection('TRIMESTER 3', visits, 'TRIMESTER_3'),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildTrimesterSection(String title, List visits, String key) {
    final filteredVisits = visits.where((v) => v['trimester'] == key).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFCF4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Symbols.pregnancy, color: Color(0xFF537C57)),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        ...filteredVisits.map((visit) => _buildVisitCard(visit)).toList(),
      ],
    );
  }

  Widget _buildVisitCard(Map<String, dynamic> visit) {
    return GestureDetector(
      onTap: () => context.push('/kondisi/${visit['id']}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF2F4EE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visit['label'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF537C57),
                    fontSize: 16,
                  ),
                ),
                Text(
                  _formatDate(visit['tanggalKunjungan']),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    visit['faskes'] ?? '',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
