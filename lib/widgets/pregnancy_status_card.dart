import 'package:flutter/material.dart';

enum PregnancyStatus { safe, warning, urgent }

class PregnancyStatusCard extends StatelessWidget {
  final PregnancyStatus status;

  const PregnancyStatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color warningOrange = Color(0xFFE5A343);
    const Color urgentRed = Color(0xFFD38D8D);

    String title;
    String subtitle = 'Semua tanda vital normal.\nTetap jaga pola makan.';
    String assetPath;
    Color titleColor;

    switch (status) {
      case PregnancyStatus.safe:
        title = 'Kehamilanmu\nberjalan baik';
        assetPath = 'assets/images/maskots/safe.png';
        titleColor = primaryGreen;
        break;
      case PregnancyStatus.warning:
        title = 'Perlu\nperhatian';
        assetPath = 'assets/images/maskots/warning.png';
        titleColor = warningOrange;
        break;
      case PregnancyStatus.urgent:
        title = 'Segera\nkonsultasi';
        assetPath = 'assets/images/maskots/danger.png';
        titleColor = urgentRed;
        break;
    }

    return Container(
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: titleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(assetPath, height: 100, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
