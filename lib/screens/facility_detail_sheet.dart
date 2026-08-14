import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'layanan_terdekat_sheet.dart';

class FacilityDetailSheet extends StatelessWidget {
  final FacilityModel facility;
  final LifelineColors tokens;
  final VoidCallback onCall112;

  const FacilityDetailSheet({
    Key? key,
    required this.facility,
    required this.tokens,
    required this.onCall112,
  }) : super(key: key);

  Future<void> _openGoogleMapsDirections(BuildContext context) async {
    final String urlString =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(facility.name)}';

    final Uri googleMapsUri = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleMapsUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🗺️ Mengalihkan ke Google Maps (${facility.name})...'),
          backgroundColor: const Color(0xFFE53935),
        ),
      );
    }
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: tokens.textDisplay,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${facility.category} · ${facility.distance} · ${facility.duration}',
                      style: TextStyle(
                        fontSize: 13,
                        color: tokens.textTertiary,
                      ),
                    ),
                  ],
                ),
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
          const SizedBox(height: LifelineSpacing.lg16),

          // EMPTY FRAME FOR MAPS (Figma exact empty container frame)
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: tokens.bgQuaternary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: tokens.borderPrimary, width: 1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 32,
                    color: tokens.textTertiary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: LifelineSpacing.sm),
                  Text(
                    'Frame Peta (Kosong)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: tokens.textTertiary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Action Buttons Row: Rute & Panggil 112
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openGoogleMapsDirections(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.navigation_rounded, size: 18),
                  label: const Text(
                    'Rute',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCall112,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: tokens.bgPrimary,
                    foregroundColor: tokens.textPrimary,
                    minimumSize: const Size(double.infinity, 50),
                    side: BorderSide(color: tokens.borderSecondary, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                  ),
                  icon: const Icon(Icons.phone_in_talk_rounded, size: 18),
                  label: const Text(
                    'Panggil 112',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bottom Full-Width Button: Buka di Google Maps
          OutlinedButton(
            onPressed: () => _openGoogleMapsDirections(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: tokens.bgPrimary,
              foregroundColor: tokens.textPrimary,
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide(color: tokens.borderSecondary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              ),
            ),
            child: const Text(
              'Buka di Google Maps',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg12),
        ],
      ),
    );
  }
}
