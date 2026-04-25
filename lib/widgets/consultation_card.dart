import 'package:flutter/material.dart';

class ConsultationCard extends StatelessWidget {
  final Map<String, dynamic> room;
  final VoidCallback onTap;

  const ConsultationCard({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    final partner = room['partner'];
    final int unreadCount = room['unreadCount'] ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFF2F4EE),
                  child: Icon(
                    partner['role'] == 'DOCTOR'
                        ? Icons.medical_services_outlined
                        : Icons.person_2_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF81C784),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partner['fullName'] ?? 'Nama Tenaga Medis',
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    partner['role'] == 'NURSE'
                        ? 'Suster / Perawat'
                        : 'Dokter Spesialis',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD38D8D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[300],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
