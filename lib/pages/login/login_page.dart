import 'package:flutter/material.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    final loginVm = context.read<LoginViewModel>();
    final authState = context.read<AuthState>();

    final success = await loginVm.login(
      _emailController.text,
      _passwordController.text,
      authState,
    );

    if (success && mounted) {
      context.go('/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loginVm.errorMessage ?? 'Login Gagal'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    const Color inputFillColor = Color(0xFFF2F4EE);
    final loginVm = context.watch<LoginViewModel>();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo-narabuna-white.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Email'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'Masukkan email anda',
                    icon: Icons.email_outlined,
                    fillColor: inputFillColor,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel('Password'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Masukkan password anda',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    fillColor: inputFillColor,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Lupa password?',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: loginVm.isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        disabledBackgroundColor: primaryGreen.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: loginVm.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Masuk',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () => context.push('/register'),
                      child: RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.grey[600],
                            fontSize: 15,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terhubung dengan data',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset('assets/images/logo-satu-sehat.png', height: 18),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required Color fillColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontFamily: 'SFProDisplay'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF537C57)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
