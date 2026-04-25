import 'package:flutter/material.dart';
import 'package:narabuna/pages/chatbot/chatbot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';
import 'package:narabuna/auth/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _handleLogout(BuildContext context) async {
    final chatViewModel = context.read<ChatViewModel>();
    final authState = context.read<AuthState>();

    chatViewModel.clearChat();

    await authState.logout();

    if (context.mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    const Color itemFillColor = Color(0xFFFDFCF4);

    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: const BottomNavbarCustom(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGSvEm0etPR7Ny96YCT_MDRqQ8B5TqjA7VPw&s',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sari Wijayanti',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '24 minggu • Trimester II • HPL 25 Jul 2025',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Akun
                  _buildSectionHeader('Akun'),
                  const SizedBox(height: 12),
                  _buildProfileItem(
                    icon: Icons.person_outline,
                    title: 'Ubah Profil',
                    onTap: () {},
                    fillColor: itemFillColor,
                  ),
                  _buildProfileItem(
                    icon: Icons.notifications_none,
                    title: 'Notifikasi',
                    onTap: () {},
                    fillColor: itemFillColor,
                  ),
                  _buildProfileItem(
                    icon: Icons.lock_outline,
                    title: 'Privasi',
                    onTap: () {},
                    fillColor: itemFillColor,
                    isLast: true,
                  ),

                  const SizedBox(height: 24),

                  // Section Bantuan
                  _buildSectionHeader('Bantuan'),
                  const SizedBox(height: 12),
                  _buildProfileItem(
                    icon: Icons.help_outline,
                    title: 'Bantuan & Dukungan',
                    onTap: () {},
                    fillColor: itemFillColor,
                  ),
                  _buildProfileItem(
                    icon: Icons.info_outline,
                    title: 'Syarat dan Kebijakan',
                    onTap: () {},
                    fillColor: itemFillColor,
                    isLast: true,
                  ),

                  const SizedBox(height: 24),

                  // Section Aksi
                  _buildSectionHeader('Aksi'),
                  const SizedBox(height: 12),
                  _buildProfileItem(
                    icon: Icons.outlined_flag,
                    title: 'Laporkan Masalah',
                    onTap: () {},
                    fillColor: itemFillColor,
                  ),
                  _buildProfileItem(
                    icon: Icons.logout,
                    title: 'Keluar',
                    titleColor: const Color(0xFFD38D8D),
                    iconColor: const Color(0xFFD38D8D),
                    fillColor: const Color(
                      0xFFF9E9E9,
                    ), // Warna kemerahan lembut sesuai desain
                    onTap: () => _handleLogout(context),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF53433E), // Warna coklat gelap sesuai label desain
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color fillColor,
    Color titleColor = Colors.black87,
    Color iconColor = Colors.black87,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
