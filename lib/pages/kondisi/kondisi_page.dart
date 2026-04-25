import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';

class KondisiPage extends StatelessWidget {
  const KondisiPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);

    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: const BottomNavbarCustom(currentIndex: 1),
      body: SingleChildScrollView(
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
                  child: Text(
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
                  padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
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
                            Expanded(
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
                              '24 / 40 minggu',
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
                              widthFactor: 0.6,
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: primaryGreen,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  '60%',
                                  style: TextStyle(
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
            _buildTrimesterCard('TRIMESTER 1'),
            _buildTrimesterCard('TRIMESTER 2'),
            _buildTrimesterCard('TRIMESTER 3'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTrimesterCard(String title) {
    return Container(
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
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
