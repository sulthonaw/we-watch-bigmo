import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:narabuna/pages/kondisi/kondisi_detail_view_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class KondisiDetailPage extends StatefulWidget {
  final String visitId;

  const KondisiDetailPage({super.key, required this.visitId});

  @override
  State<KondisiDetailPage> createState() => _KondisiDetailPageState();
}

class _KondisiDetailPageState extends State<KondisiDetailPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthState>().token;
      if (token != null) {
        context.read<KondisiDetailViewModel>().fetchVisitDetail(
          token,
          widget.visitId,
        );
      }
    });
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return '--';
    final date = DateTime.parse(dateStr).toLocal();
    return DateFormat('EEEE, d MMMM yyyy • HH:mm', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);
    const Color itemFillColor = Color(0xFFFDFCF4);
    const Color warningBg = Color(0xFFFDF4F4);
    const Color warningText = Color(0xFFD38D8D);

    final viewModel = context.watch<KondisiDetailViewModel>();
    final data = viewModel.visitData;

    if (viewModel.isLoading) {
      return const Scaffold(
        backgroundColor: scaffoldBg,
        body: Center(child: CircularProgressIndicator(color: primaryGreen)),
      );
    }

    if (data == null) {
      return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(backgroundColor: scaffoldBg, elevation: 0),
        body: const Center(child: Text('Data tidak ditemukan')),
      );
    }

    final mother = data['motherExamination'];
    final fetal = data['fetalExamination'];
    final lab = data['labExamination'];
    final plans = (data['followUpPlans'] as List?) ?? [];

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
        title: const Text(
          'Detail Kunjungan',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
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
              title:
                  '${data['label']} • ${data['trimester'].toString().replaceAll('_', ' ')}',
              subtitle: _formatDateTime(data['tanggalKunjungan']),
              icon: Icons.calendar_today_outlined,
              primaryColor: primaryGreen,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: data['pemeriksa'] ?? '--',
              subtitle: data['faskes'] ?? '--',
              icon: Icons.person_outline_rounded,
              primaryColor: primaryGreen,
            ),
            const SizedBox(height: 24),
            const Text(
              'Kesan Klinis',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            _buildClinicalImpressionCard(
              fillColor: itemFillColor,
              impression: data['kesanKlinis'] ?? 'Tidak ada kesan klinis.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Vital Statistics',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            _buildVitalStatsGrid(
              fillColor: const Color(0xFFF2F4EE),
              mother: mother,
              fetal: fetal,
            ),
            const SizedBox(height: 24),
            const Text(
              'Masalah yang ditemukan',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            if (mother?['lilaInterpretasi'] != 'Normal')
              _buildIssueItem(
                fillColor: warningBg,
                textColor: warningText,
                icon: Icons.report_problem_outlined,
                issue: mother?['lilaInterpretasi'] ?? 'KEK',
                description: mother?['lilaKeterangan'] ?? '',
              ),
            if (lab?['hemoglobinInterpretasi'] != 'Normal')
              _buildIssueItem(
                fillColor: warningBg,
                textColor: warningText,
                icon: Icons.bloodtype_outlined,
                issue: lab?['hemoglobinInterpretasi'] ?? 'Anemia',
                description: lab?['hemoglobinKeterangan'] ?? '',
              ),
            const SizedBox(height: 24),
            const Text(
              'Rencana Tindakan',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            ...plans.map(
              (plan) => _buildActionItem(
                fillColor: const Color(0xFFF2F4EE),
                icon: plan['status']
                    ? Icons.check_circle_outline_rounded
                    : Icons.radio_button_unchecked,
                action: plan['keterangan'] ?? '',
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
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
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
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
              style: const TextStyle(
                fontFamily: 'SFProDisplay',
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

  Widget _buildVitalStatsGrid({
    required Color fillColor,
    Map<String, dynamic>? mother,
    Map<String, dynamic>? fetal,
  }) {
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
              '${mother?['tdSistolik'] ?? '--'}/${mother?['tdDiastolik'] ?? '--'}',
              'mmHg',
            ),
            _buildVitalItem(
              width,
              fillColor,
              'Hemoglobin',
              '${context.watch<KondisiDetailViewModel>().visitData?['labExamination']?['hemoglobinGdL'] ?? '--'}',
              'g/dL',
            ),
            _buildVitalItem(
              width,
              fillColor,
              'Detak jantung bayi',
              '${fetal?['djjBpm'] ?? '--'}',
              'bpm',
            ),
            _buildVitalItem(
              width,
              fillColor,
              'LILA',
              '${mother?['lilaCm'] ?? '--'}',
              'cm',
            ),
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
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
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
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
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
              style: const TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
