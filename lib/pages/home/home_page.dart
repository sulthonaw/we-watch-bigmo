import 'package:flutter/material.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);

    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: BottomNavbarCustom(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(radius: 26),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat pagi,',
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Sari Wijayanti',
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kondisi Anda',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Perlu perhatian',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: primaryGreen,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Hb masih rendah, perlu tindakan',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hari ini',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildAction('Minum tablet tambah darah'),
                        _buildAction('Makan tinggi zat besi'),
                        _buildAction('Kontrol ke bidan'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSimpleStat('Tekanan darah', 'Normal'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _buildSimpleStat('Darah (Hb)', 'Rendah')),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F1F1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Segera ke faskes jika:',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('• Pendarahan tiba-tiba'),
                        Text('• Sakit kepala hebat'),
                        Text('• Bayi tidak bergerak'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.circle_outlined, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String title, String status) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            status,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
