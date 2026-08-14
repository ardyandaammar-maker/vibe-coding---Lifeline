import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/incident_store.dart';

class RiwayatDetailSheet extends StatelessWidget {
  final LifelineColors tokens;
  final IncidentModel incident;

  const RiwayatDetailSheet({
    Key? key,
    required this.tokens,
    required this.incident,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      incident.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: tokens.textDisplay,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xs),
                    Text(
                      incident.dateMeta,
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
          const SizedBox(height: LifelineSpacing.xl3),
          
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LifelineSpacing.lg16),
                    decoration: BoxDecoration(
                      color: tokens.bgSecondary,
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'STATUS',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF9CA3AF),
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              incident.outcome,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF079455), // Green color matching outcome
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: LifelineSpacing.lg12),
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF2563EB),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: LifelineSpacing.lg12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    incident.location,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: tokens.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: LifelineSpacing.xxs),
                                  Text(
                                    'Lokasi terdeteksi otomatis',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: tokens.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),

                  // Empty Map Box
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),

                  // Shared To Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LifelineSpacing.lg16),
                    decoration: BoxDecoration(
                      color: tokens.bgSecondary,
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DIBAGIKAN KE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9CA3AF),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: LifelineSpacing.lg12),
                        Row(
                          children: [
                            _buildSharedChip('112'),
                            const SizedBox(width: LifelineSpacing.md),
                            _buildSharedChip('4 kontak darurat'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),

                  // Notes Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LifelineSpacing.lg16),
                    decoration: BoxDecoration(
                      color: tokens.bgSecondary,
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CATATAN',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9CA3AF),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: LifelineSpacing.sm),
                        Text(
                          'Lokasi GPS dan Medical ID tersampaikan. Tidak ada panggilan aktual ke 112.',
                          style: TextStyle(
                            fontSize: 13,
                            color: tokens.textTertiary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xl3),
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigation_outlined, size: 18),
                  label: const Text(
                    'Buka Maps',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined, size: 18),
                  label: const Text(
                    'Panggil 112',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF374151),
                    minimumSize: const Size(double.infinity, 50),
                    side: BorderSide(color: tokens.borderPrimary, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.lg12),
          OutlinedButton.icon(
            onPressed: () {
              IncidentStore().removeIncident(incident);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text(
              'Hapus Riwayat',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE53935),
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: Color(0xFFE53935), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg16),
        ],
      ),
    );
  }

  Widget _buildSharedChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg12, vertical: LifelineSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(LifelineRadius.xl3),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1), // Optional very subtle border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.medical_services_outlined, // Stethoscope-like icon
            size: 14,
            color: Color(0xFF2563EB),
          ),
          const SizedBox(width: LifelineSpacing.sm),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}
