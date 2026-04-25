import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    const Color inputFillColor = Color(0xFFF2F4EE);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
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
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/logo-narabuna-white.png',
                    height: 80,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Daftar Akun Baru',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Nama Lengkap'),
                  _buildTextField(
                    controller: _fullNameController,
                    hint: 'Masukkan nama lengkap',
                    icon: Icons.person_outline,
                    fillColor: inputFillColor,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('Username'),
                  _buildTextField(
                    controller: _usernameController,
                    hint: 'Buat username unik',
                    icon: Icons.alternate_email,
                    fillColor: inputFillColor,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('NIK'),
                  _buildTextField(
                    controller: _nikController,
                    hint: 'Masukkan 16 digit NIK',
                    icon: Icons.badge_outlined,
                    fillColor: inputFillColor,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('Email'),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'user@example.com',
                    icon: Icons.email_outlined,
                    fillColor: inputFillColor,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('Password'),
                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Minimal 8 karakter',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    fillColor: inputFillColor,
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: 'SFProDisplay',
                          ),
                          children: const [
                            TextSpan(
                              text: 'Masuk',
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

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terhubung dengan data',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset('assets/images/logo-satu-sehat.png', height: 16),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required Color fillColor,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(fontFamily: 'SFProDisplay', fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF537C57), size: 22),
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
