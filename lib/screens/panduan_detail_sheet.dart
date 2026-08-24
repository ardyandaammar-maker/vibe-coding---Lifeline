import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'panduan_screen.dart';

class PanduanDetailSheet extends StatelessWidget {
  final LifelineColors tokens;
  final FirstAidCategory guide;

  const PanduanDetailSheet({
    Key? key,
    required this.tokens,
    required this.guide,
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
      // Set fixed height or use isScrollControlled for full height, we assume it's wrapped in SingleChildScrollView
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                guide.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: tokens.textDisplay,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: LifelineSpacing.xxs),
              Text(
                guide.description,
                style: TextStyle(
                  fontSize: 13,
                  color: tokens.textTertiary,
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
                  // Call For Help Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(LifelineRadius.xl3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KAPAN PANGGIL BANTUAN',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFEF4444),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: LifelineSpacing.sm),
                        Text(
                          guide.callForHelpText,
                          style: TextStyle(
                            fontSize: 13,
                            color: tokens.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xl3),

                  // Steps
                  const Text(
                    'LANGKAH-LANGKAH',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg12),
                  ...guide.steps.asMap().entries.map((e) {
                    final index = e.key + 1;
                    final step = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: tokens.bgSecondary,
                          borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2563EB),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$index',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: LifelineSpacing.lg12),
                            Expanded(
                              child: Text(
                                step,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: tokens.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 14),

                  // Warnings
                  const Text(
                    'PERINGATAN',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD97706),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg12),
                  ...guide.warnings.map((warn) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFD97706),
                              size: 20,
                            ),
                            const SizedBox(width: LifelineSpacing.lg12),
                            Expanded(
                              child: Text(
                                warn,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: tokens.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 14),

                  // Note
                  if (guide.note.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
                      decoration: BoxDecoration(
                        color: tokens.bgSecondary,
                        borderRadius: BorderRadius.circular(LifelineRadius.xl3),
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
                            guide.note,
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
          
          // Button
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
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
              'Tutup Panduan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg16),
        ],
      ),
    );
  }
}
