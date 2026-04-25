import 'package:flutter/material.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:narabuna/pages/home/home_view_model.dart';
import 'package:narabuna/widgets/bottom_navbar_custom.dart';
import 'package:narabuna/widgets/pregnancy_status_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthState>().token;
      if (token != null) {
        context.read<HomeViewModel>().fetchData(token);
      }
    });
  }

  PregnancyStatus _mapRiskLevel(String? riskLevel) {
    switch (riskLevel) {
      case 'low risk':
        return PregnancyStatus.safe;
      case 'mid risk':
        return PregnancyStatus.warning;
      case 'high risk':
        return PregnancyStatus.urgent;
      default:
        return PregnancyStatus.safe;
    }
  }

  void _showExplanation(String title, String explanation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF537C57),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  explanation,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    final homeVm = context.watch<HomeViewModel>();

    final lastVisit = (homeVm.visitsData?['visits'] as List?)?.first;
    final motherEx = lastVisit?['motherExamination'];
    final fetalEx = lastVisit?['fetalExamination'];
    final labEx = lastVisit?['labExamination'];
    final plans = lastVisit?['followUpPlans'] as List?;

    const Color primaryGreen = Color(0xFF537C57);
    const Color scaffoldBg = Color(0xFFF9F9F5);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavbarCustom(currentIndex: 0),
      body: homeVm.isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryGreen))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const SizedBox(height: 280, width: double.infinity),

                      _buildHeader(authState.fullName),

                      _buildStatusSection(homeVm),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Data ANC Terakhir',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Tekanan darah',
                                '${motherEx?['tdSistolik'] ?? '--'}/${motherEx?['tdDiastolik'] ?? '--'}',
                                Icons.speed,
                                motherEx?['tdInterpretasi'] ?? 'Unknown',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                'Hemoglobin',
                                '${labEx?['hemoglobinGdL'] ?? '--'}',
                                Icons.bloodtype_outlined,
                                labEx?['hemoglobinInterpretasi'] ?? 'Unknown',
                                unit: ' g/dL',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Detak jantung bayi',
                                '${fetalEx?['djjBpm'] ?? '--'}',
                                Icons.favorite,
                                fetalEx?['djjInterpretasi'] ?? 'Unknown',
                                unit: ' bpm',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                'LILA (Gizi)',
                                '${motherEx?['lilaCm'] ?? '--'}',
                                Icons.straighten_outlined,
                                motherEx?['lilaInterpretasi'] ?? 'Unknown',
                                unit: ' cm',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (lastVisit?['kesanKlinis'] != null)
                    _buildInsightSection(
                      'Masalah Saat Ini',
                      lastVisit!['kesanKlinis'],
                      Icons.report_problem_outlined,
                      const Color(0xFFFDFCF4),
                    ),

                  const SizedBox(height: 16),

                  if (plans != null && plans.isNotEmpty)
                    _buildActionSection(plans),

                  const SizedBox(height: 16),

                  _buildInfoTile(
                    'Jadwal Kontrol Berikutnya',
                    'Idealnya 4 minggu lagi (Trimester 2)',
                    Icons.calendar_month_outlined,
                    primaryGreen,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(String? name) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF537C57),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Terhubung dengan data',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Image.asset('assets/images/logo-satu-sehat.png', height: 16),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGSvEm0etPR7Ny96YCT_MDRqQ8B5TqjA7VPw&s',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat pagi,',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        name ?? "Bunda",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xFF537C57),
                      size: 28,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD38D8D),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(HomeViewModel vm) {
    return Positioned(
      top: 160,
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          if (vm.classification != null) {
            _showExplanation(
              "Analisis Kehamilan",
              vm.classification!['explanation'],
            );
          }
        },
        child: PregnancyStatusCard(
          status: _mapRiskLevel(vm.classification?['riskLevel']),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    String status, {
    String unit = '',
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4EE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'SFProDisplay',
                color: Color(0xFF9BAB86),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: const Color(0xFF537C57)),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 12,
              color: Colors.black87,
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
                  text: unit,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightSection(
    String title,
    String content,
    IconData icon,
    Color bg,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFD4CC9C)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(List plans) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4EE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Apa yang harus Bunda lakukan?',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...plans
              .map(
                (plan) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        plan['status']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: plan['status']
                            ? const Color(0xFF537C57)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          plan['keterangan'],
                          style: const TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
