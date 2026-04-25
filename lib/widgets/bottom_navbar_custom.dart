import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class BottomNavbarCustom extends StatelessWidget {
  final int currentIndex;

  const BottomNavbarCustom({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    // switch (index) {
    //   case 0:
    //     context.push('/home');
    //     break;
    //   case 1:
    //     context.push('/kondisi');
    //     break;
    //   case 2:
    //     context.push('/chatbot');
    //     break;
    //   case 3:
    //     context.push('/todo');
    //     break;
    //   case 4:
    //     context.push('/profile');
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color inactiveColor = Color(0xFFB0B3C7);
    const Color fabColor = Color(0xFFB1C08B);

    return Container(
      height: 115,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  0,
                  Icons.home_filled,
                  'Home',
                  primaryGreen,
                  inactiveColor,
                ),
                _buildNavItem(
                  context,
                  1,
                  Icons.analytics_outlined,
                  'Kondisi',
                  primaryGreen,
                  inactiveColor,
                ),
                const SizedBox(width: 80),
                _buildNavItem(
                  context,
                  3,
                  Icons.check_circle_outline_rounded,
                  'To do',
                  primaryGreen,
                  inactiveColor,
                ),
                _buildNavItem(
                  context,
                  4,
                  Icons.person_outline_rounded,
                  'Profil',
                  primaryGreen,
                  inactiveColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => _onItemTapped(context, 2),
              child: Column(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: fabColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.smart_toy_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tanya NANA',
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    Color activeColor,
    Color inactiveColor,
  ) {
    final bool isActive = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(context, index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? activeColor : inactiveColor, size: 30),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
