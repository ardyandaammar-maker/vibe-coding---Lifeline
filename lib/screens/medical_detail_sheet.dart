import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MedicalDetailSheet extends StatelessWidget {
  final LifelineColors tokens;
  final String label;
  final String value;
  final String description;
  final VoidCallback onEdit;

  const MedicalDetailSheet({
    Key? key,
    required this.tokens,
    required this.label,
    required this.value,
    required this.description,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tokens.bgPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: tokens.borderSecondary,
                borderRadius: BorderRadius.circular(LifelineRadius.xxs),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: tokens.textDisplay,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xxs),
                  Text(
                    'Detail spesifikasi kesehatan',
                    style: TextStyle(
                      fontSize: 13,
                      color: tokens.textTertiary,
                    ),
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: tokens.bgSecondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close, size: 18, color: tokens.textTertiary),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.xl3),

          // Value Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: 18),
            decoration: BoxDecoration(
              color: tokens.bgQuaternary.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(LifelineRadius.xl3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: tokens.textTertiary,
                  ),
                ),
                const SizedBox(height: LifelineSpacing.sm),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: tokens.textDisplay,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: tokens.textTertiary,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Safety List 1
          Row(
            children: [
              const Icon(
                Icons.shield_outlined,
                color: Color(0xFF2563EB),
                size: 20,
              ),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(
                child: Text(
                  'Terenkripsi, dibagikan hanya saat SOS aktif',
                  style: TextStyle(
                    fontSize: 13,
                    color: tokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.lg12),

          // Safety List 2
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF10B981),
                size: 20,
              ),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(
                child: Text(
                  'Terlihat di layar terkunci untuk petugas',
                  style: TextStyle(
                    fontSize: 13,
                    color: tokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onEdit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Ubah informasi ini',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl3),
        ],
      ),
    );
  }
}
