import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'riwayat_detail_sheet.dart';
import '../data/incident_store.dart';

class RiwayatScreen extends StatelessWidget {
  final LifelineColors tokens;

  const RiwayatScreen({
    Key? key,
    required this.tokens,
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
            'Riwayat',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xs),

          // Title
          Text(
            'Kejadian daruratmu.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),
          const SizedBox(height: LifelineSpacing.sm),

          // Subtitle
          Text(
            'Tercatat aman. Dapat dihapus kapan saja.',
            style: TextStyle(
              fontSize: 13,
              color: tokens.textTertiary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Incidents List
          ValueListenableBuilder<List<IncidentModel>>(
            valueListenable: IncidentStore().incidents,
            builder: (context, incidents, _) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: incidents.length,
                separatorBuilder: (ctx, idx) => const SizedBox(height: LifelineSpacing.lg12),
                itemBuilder: (ctx, idx) {
                  final incident = incidents[idx];
                  return _buildIncidentCard(context, tokens, incident);
                },
              );
            },
          ),
          const SizedBox(height: LifelineSpacing.lg16),

          // 12 Month Retention Info Container (Dotted border)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: LifelineSpacing.xl2),
            decoration: BoxDecoration(
              color: tokens.bgSecondary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: tokens.borderSecondary,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 24,
                  color: tokens.textTertiary.withValues(alpha: 0.7),
                ),
                const SizedBox(height: LifelineSpacing.md),
                Text(
                  'Data disimpan hingga 12 bulan.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: tokens.textTertiary,
                  ),
                ),
              ],
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

  Widget _buildIncidentCard(BuildContext context, LifelineColors tokens, IncidentModel incident) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) => FractionallySizedBox(
            heightFactor: 0.9,
            child: RiwayatDetailSheet(
              tokens: tokens,
              incident: incident,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(LifelineSpacing.lg16),
        decoration: BoxDecoration(
          color: tokens.bgSecondary,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: tokens.borderPrimary.withValues(alpha: 0.6), width: 1),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                incident.dateMeta,
                style: TextStyle(
                  fontSize: 12,
                  color: tokens.textTertiary,
                ),
              ),
              Text(
                incident.status,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF079455),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.md),

          Text(
            incident.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: tokens.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xs),

          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: tokens.textTertiary),
              const SizedBox(width: LifelineSpacing.xs),
              Text(
                incident.location,
                style: TextStyle(
                  fontSize: 13,
                  color: tokens.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

            Text(
              incident.outcome,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: tokens.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
