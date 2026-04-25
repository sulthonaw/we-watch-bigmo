import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KondisiDetailPage extends StatelessWidget {
  final String visitId;

  const KondisiDetailPage({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    const Color itemFillColor = Color(0xFFFDFCF4);
    const Color warningBg = Color(0xFFFDF4F4);
    const Color warningText = Color(0xFFD38D8D);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Kunjungan',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'K3 • Trimester II',
              subtitle: 'Selasa, 14 Mei 2024 • 12:30',
              icon: Icons.calendar_today_outlined,
              primaryColor: primaryGreen,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Bidan Eka Pratiwi',
              subtitle: 'Puskesmas Sidoarjo Kota',
              icon: Icons.person_outline_rounded,
              primaryColor: primaryGreen,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Analisis Risiko'),
            const SizedBox(height: 12),
            _buildRiskCard(
              title: 'Perlu perhatian',
              explanation:
                  'Hasil klasifikasi risiko kehamilan Anda saat ini berada di kategori "sedang" (mid risk), yang berarti ada sekitar 49,3% kemungkinan kehamilan berjalan normal dengan perawatan yang baik.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Kesan Klinis'),
            const SizedBox(height: 12),
            _buildClinicalImpressionCard(
              fillColor: itemFillColor,
              impression:
                  'G1P0A0 hamil 19 minggu dengan KEK (LILA 22 cm) dan anemia ringan (Hb 10.5 g/dL). Tinggi fundus sedikit di bawah usia kehamilan, kemungkinan terkait status gizi.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Vital Statistics'),
            const SizedBox(height: 12),
            _buildVitalStatsGrid(fillColor: const Color(0xFFF2F4EE)),
            const SizedBox(height: 24),
            _buildSectionTitle('Masalah yang ditemukan'),
            const SizedBox(height: 12),
            _buildIssueItem(
              fillColor: warningBg,
              textColor: warningText,
              icon: Icons.report_problem_outlined,
              issue: 'Kurang Energi Kronis (KEK)',
              description: 'LILA < 23.5 cm (22 cm)',
            ),
            _buildIssueItem(
              fillColor: warningBg,
              textColor: warningText,
              icon: Icons.bloodtype_outlined,
              issue: 'Anemia Ringan',
              description: 'Hb < 11.0 g/dL (10.5 g/dL)',
            ),
            _buildIssueItem(
              fillColor: warningBg,
              textColor: warningText,
              icon: Icons.straighten_outlined,
              issue: 'Tinggi Fundus Rendah',
              description: 'Sedikit di bawah usia kehamilan',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Rencana Tindakan'),
            const SizedBox(height: 12),
            _buildActionItem(
              fillColor: const Color(0xFFF2F4EE),
              icon: Icons.check_circle_outline_rounded,
              action:
                  'Pemberian Makanan Tambahan (MT Lokal) selama minimal 90 hari',
            ),
            _buildActionItem(
              fillColor: const Color(0xFFF2F4EE),
              icon: Icons.radio_button_unchecked,
              action: 'Suplementasi Fe 2 tablet/hari (dosis anemia)',
            ),
            _buildActionItem(
              fillColor: const Color(0xFFF2F4EE),
              icon: Icons.radio_button_unchecked,
              action: 'Edukasi gizi seimbang dengan tinggi protein hewani',
            ),
            _buildActionItem(
              fillColor: const Color(0xFFF2F4EE),
              icon: Icons.radio_button_unchecked,
              action: 'Kontrol Hb ulang dalam 4 minggu',
            ),
            _buildActionItem(
              fillColor: const Color(0xFFF2F4EE),
              icon: Icons.radio_button_unchecked,
              action: 'Pantau kenaikan BB ketat tiap kunjungan',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF333333),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color primaryColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard({required String title, required String explanation}) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE5A343),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  explanation,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/images/maskots/warning.png', height: 80),
        ],
      ),
    );
  }

  Widget _buildClinicalImpressionCard({
    required Color fillColor,
    required String impression,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.psychology_outlined, color: Color(0xFFD4CC9C)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              impression,
              style: GoogleFonts.nunito(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalStatsGrid({required Color fillColor}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildVitalItem(
              width,
              fillColor,
              'Tekanan darah',
              '100/65',
              'mmHg',
            ),
            _buildVitalItem(width, fillColor, 'Hemoglobin', '10.5', 'g/dL'),
            _buildVitalItem(
              width,
              fillColor,
              'Detak jantung bayi',
              '150',
              'bpm',
            ),
            _buildVitalItem(width, fillColor, 'LILA', '22', 'cm'),
          ],
        );
      },
    );
  }

  Widget _buildVitalItem(
    double width,
    Color fillColor,
    String title,
    String value,
    String unit,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueItem({
    required Color fillColor,
    required Color textColor,
    required IconData icon,
    required String issue,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required Color fillColor,
    required IconData icon,
    required String action,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: icon == Icons.check_circle_outline_rounded
                ? const Color(0xFF537C57)
                : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              action,
              style: GoogleFonts.nunito(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
