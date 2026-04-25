import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    this.isRead = false,
  });
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);

    final Map<String, List<NotificationItem>> notifications = {
      'Hari Ini': [
        NotificationItem(
          title: 'Waktunya Kontrol Rutin',
          body:
              'Bunda, jadwal kontrol K4 sudah dekat. Jangan lupa ke Puskesmas besok pagi ya!',
          time: '08:00',
          icon: Icons.calendar_today_rounded,
          iconBgColor: const Color(0xFFE5E9D9),
        ),
        NotificationItem(
          title: 'Tips Nutrisi Hari Ini',
          body:
              'Konsumsi makanan tinggi protein hewani sangat baik untuk pertumbuhan janin di Trimester 2.',
          time: '07:30',
          icon: Icons.restaurant_rounded,
          iconBgColor: const Color(0xFFFDF4F4),
        ),
      ],
      'Kemarin': [
        NotificationItem(
          title: 'Hasil Lab Tersedia',
          body:
              'Hasil pemeriksaan Hb Bunda sudah keluar. Silakan cek di menu Kondisi.',
          time: '15:20',
          icon: Icons.science_outlined,
          iconBgColor: const Color(0xFFF2F4EE),
          isRead: true,
        ),
      ],
    };

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          String sectionTitle = notifications.keys.elementAt(index);
          List<NotificationItem> items = notifications[sectionTitle]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 16, bottom: 12),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...items
                  .map((item) => _buildNotificationCard(item, primaryGreen))
                  .toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: primaryColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (!item.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD38D8D),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.time,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
