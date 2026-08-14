import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/medical_data.dart';
import 'medical_detail_sheet.dart';


class MedicalIdScreen extends StatelessWidget {
  final MedicalData data;
  final LifelineColors tokens;
  final VoidCallback onEditMedicalId;

  const MedicalIdScreen({
    Key? key,
    required this.data,
    required this.tokens,
    required this.onEditMedicalId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.lg12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tag
          const Text(
            'Medical ID',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xs),

          // Main Header Title
          Text(
            'Informasi medismu.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: LifelineSpacing.sm),

          // Subtitle
          Text(
            'Bisa diakses petugas darurat tanpa perlu membuka kunci.',
            style: TextStyle(
              fontSize: 13,
              color: tokens.textTertiary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Hero Dark Profile Card
          _buildHeroProfileCard(tokens),
          const SizedBox(height: LifelineSpacing.lg16),

          // 4 Medical Information Cards
          _buildMedicalCard(
            context: context,
            tokens: tokens,
            icon: Icons.water_drop_outlined,
            iconColor: const Color(0xFFE53935),
            iconBg: const Color(0xFFFEF2F2),
            label: 'Alergi',
            value: data.allergies,
            description: 'Petugas darurat akan menghindari zat ini saat memberi penanganan atau obat.',
          ),
          const SizedBox(height: 10),

          _buildMedicalCard(
            context: context,
            tokens: tokens,
            icon: Icons.medication_outlined,
            iconColor: const Color(0xFF2563EB),
            iconBg: const Color(0xFFEFF6FF),
            label: 'Obat Rutin',
            value: data.medications,
            description: 'Informasi obat rutin membantu petugas mencegah interaksi obat berbahaya.',
          ),
          const SizedBox(height: 10),

          _buildMedicalCard(
            context: context,
            tokens: tokens,
            icon: Icons.favorite_border_rounded,
            iconColor: const Color(0xFFE53935),
            iconBg: const Color(0xFFFEF2F2),
            label: 'Kondisi',
            value: data.conditions,
            description: 'Kondisi kesehatan memberikan konteks penting bagi tindakan medis pertama.',
          ),
          const SizedBox(height: 10),

          _buildMedicalCard(
            context: context,
            tokens: tokens,
            icon: Icons.monitor_heart_outlined,
            iconColor: const Color(0xFF2563EB),
            iconBg: const Color(0xFFEFF6FF),
            label: 'Donor Organ',
            value: data.donor,
            description: 'Informasi ini akan diteruskan ke otoritas medis yang berwenang jika dibutuhkan.',
          ),
          const SizedBox(height: LifelineSpacing.xl3),

          // Edit Medical ID Button
          ElevatedButton(
            onPressed: onEditMedicalId,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Edit Medical ID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Disclaimer Note
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16),
              child: Text(
                'Data medismu dienkripsi end-to-end dan hanya dibagikan saat SOS aktif.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: tokens.textTertiary,
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Footer Note
          Center(
            child: Text(
              'Lifeline • Setiap detik penting',
              style: TextStyle(
                fontSize: 11,
                color: tokens.textTertiary.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),
        ],
      ),
    );
  }

  Widget _buildHeroProfileCard(LifelineColors tokens) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LifelineSpacing.xl2),
      decoration: BoxDecoration(
        color: const Color(0xFF141721),
        borderRadius: BorderRadius.circular(LifelineRadius.xl4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemilik',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xxs),
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xxs),
                    Text(
                      '${data.age} tahun · ${data.gender}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.xl3),

          // 3 Metrics Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gol. Darah',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xs),
                    Text(
                      data.bloodType,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Berat',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xs),
                    Text(
                      data.weight,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tinggi',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xs),
                    Text(
                      data.height,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalCard({
    required BuildContext context,
    required LifelineColors tokens,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required String description,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => MedicalDetailSheet(
              tokens: tokens,
              label: label,
              value: value,
              description: description,
              onEdit: onEditMedicalId,
            ),
          );
        },
        borderRadius: BorderRadius.circular(LifelineRadius.xl3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
          decoration: BoxDecoration(
            color: tokens.bgSecondary,
            borderRadius: BorderRadius.circular(LifelineRadius.xl3),
            border: Border.all(color: tokens.borderPrimary.withValues(alpha: 0.6), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: tokens.textTertiary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xxs),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: tokens.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
