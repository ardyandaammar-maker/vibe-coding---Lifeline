import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/incident_store.dart';

class SosActiveScreen extends StatefulWidget {
  final VoidCallback onEndSos;

  const SosActiveScreen({
    Key? key,
    required this.onEndSos,
  }) : super(key: key);

  @override
  State<SosActiveScreen> createState() => _SosActiveScreenState();
}

class _SosActiveScreenState extends State<SosActiveScreen> {
  int _callSeconds = 12;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callSeconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0E12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.xl2),
          child: Column(
            children: [
              const SizedBox(height: LifelineSpacing.lg16),

              // SOS Active Pulse Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE53935),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: LifelineSpacing.md),
                  Text(
                    'SOS Aktif',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LifelineSpacing.xl2),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bantuan sedang\n',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                        letterSpacing: -0.4,
                      ),
                    ),
                    TextSpan(
                      text: 'dalam perjalanan.',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 4 Emergency Live Status Cards
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildStatusCard(
                      icon: Icons.check_circle_rounded,
                      iconColor: const Color(0xFF079455),
                      title: 'Menghubungi 112',
                      subtitle: 'Terhubung — ${_formatTimer(_callSeconds)}',
                    ),
                    const SizedBox(height: LifelineSpacing.lg12),
                    _buildStatusCard(
                      icon: Icons.check_circle_rounded,
                      iconColor: const Color(0xFF079455),
                      title: 'Lokasi GPS dibagikan',
                      subtitle: 'Jl. Palmerah Barat 12, Jakarta',
                    ),
                    const SizedBox(height: LifelineSpacing.lg12),
                    _buildStatusCard(
                      icon: Icons.check_circle_rounded,
                      iconColor: const Color(0xFF079455),
                      title: 'Medical ID dikirim',
                      subtitle: 'Ke 4 kontak darurat',
                    ),
                    const SizedBox(height: LifelineSpacing.lg12),
                    _buildStatusCard(
                      icon: Icons.blur_on_rounded,
                      iconColor: Colors.white70,
                      title: 'Menunggu petugas medis',
                      subtitle: 'ETA ambulans mitra: 8 menit',
                      isPending: true,
                    ),
                  ],
                ),
              ),

              // Akhiri SOS Button
              ElevatedButton(
                onPressed: () {
                  IncidentStore().addIncident(
                    IncidentModel(
                      dateMeta: 'Hari ini • Baru saja',
                      status: 'Selesai',
                      title: 'Panggilan Darurat SOS',
                      location: 'Lokasi Saat Ini (Otomatis)',
                      outcome: 'Dihentikan manual',
                    ),
                  );
                  widget.onEndSos();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.close_rounded, size: 20),
                    SizedBox(width: LifelineSpacing.md),
                    Text(
                      'Akhiri SOS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LifelineSpacing.lg16),

              // Disclaimer
              Text(
                'Hanya batalkan jika keadaan sudah aman.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: LifelineSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool isPending = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: LifelineSpacing.lg16),
      decoration: BoxDecoration(
        color: const Color(0xFF141721),
        borderRadius: BorderRadius.circular(LifelineRadius.xl3),
        border: Border.all(
          color: isPending ? Colors.white.withValues(alpha: 0.08) : const Color(0xFF079455).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isPending ? Colors.white.withValues(alpha: 0.08) : const Color(0xFF079455).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPending ? Colors.white70 : iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.6),
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
