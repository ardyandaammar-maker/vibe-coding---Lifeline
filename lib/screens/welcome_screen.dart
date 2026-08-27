import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStartRegister;
  final VoidCallback onGoSignIn;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const WelcomeScreen({
    Key? key,
    required this.onStartRegister,
    required this.onGoSignIn,
    required this.onToggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<LifelineColors>() ?? LifelineColors.light;

    return Scaffold(
      backgroundColor: tokens.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
              color: tokens.fgPrimary,
            ),
            onPressed: onToggleTheme,
            tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl3, vertical: LifelineSpacing.lg12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Icon Badge
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tokens.iconBadgeBg,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.shield_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl3),

              // Title
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Setiap detik\n',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: tokens.textDisplay,
                        height: 1.15,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'menentukan.',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: tokens.textBrandPrimary,
                        height: 1.15,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LifelineSpacing.lg12),

              // Subtitle
              Text(
                'Lifeline mengirim panggilan darurat, lokasi, dan Medical ID kamu secara otomatis — hanya dengan satu tombol.',
                style: TextStyle(
                  fontSize: 14,
                  color: tokens.textTertiary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl3),

              // 3 Feature Cards
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildFeatureCard(
                      context,
                      tokens: tokens,
                      icon: Icons.favorite_border_rounded,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFEFF6FF),
                      title: 'Medical ID',
                      subtitle: 'Golongan darah, alergi, dan obat tersimpan aman.',
                    ),
                    const SizedBox(height: LifelineSpacing.lg12),
                    _buildFeatureCard(
                      context,
                      tokens: tokens,
                      icon: Icons.location_on_outlined,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFEFF6FF),
                      title: 'Lokasi presisi',
                      subtitle: 'Dibagikan otomatis ke layanan darurat.',
                    ),
                    const SizedBox(height: LifelineSpacing.lg12),
                    _buildFeatureCard(
                      context,
                      tokens: tokens,
                      icon: Icons.people_outline_rounded,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFEFF6FF),
                      title: 'Kontak darurat',
                      subtitle: 'Keluarga langsung diberi tahu.',
                    ),
                  ],
                ),
              ),

              // Bottom Actions
              Column(
                children: [
                  ElevatedButton(
                    onPressed: onStartRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tokens.buttonPrimaryBg,
                      foregroundColor: tokens.buttonPrimaryFg,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Mulai sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: LifelineSpacing.md),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg12),
                  OutlinedButton(
                    onPressed: onGoSignIn,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: tokens.buttonSecondaryBg,
                      foregroundColor: tokens.buttonSecondaryFg,
                      minimumSize: const Size(double.infinity, 54),
                      side: BorderSide(color: tokens.buttonSecondaryBorder, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                      ),
                    ),
                    child: const Text(
                      'Sudah punya akun? Masuk',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg12),

                  // Lanjutkan dengan Google Button
                  OutlinedButton(
                    onPressed: onGoSignIn,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: tokens.bgPrimary,
                      foregroundColor: tokens.textPrimary,
                      minimumSize: const Size(double.infinity, 54),
                      side: BorderSide(color: tokens.borderPrimary, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CustomPaint(painter: GoogleLogoPainter()),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tokens.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  Widget _buildFeatureCard(
    BuildContext context, {
    required LifelineColors tokens,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(LifelineSpacing.lg16),
      decoration: BoxDecoration(
        color: tokens.bgSecondary,
        borderRadius: BorderRadius.circular(LifelineRadius.xl2),
        border: Border.all(color: tokens.borderPrimary.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: tokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: tokens.textTertiary,
                    height: 1.3,
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

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double strokeWidth = width * 0.22;
    final Offset center = Offset(width / 2, height / 2);
    final double radius = (width - strokeWidth) / 2;

    final Paint redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, -0.785, 2.356, false, redPaint);
    canvas.drawArc(rect, 1.571, 1.178, false, yellowPaint);
    canvas.drawArc(rect, 2.749, 1.571, false, greenPaint);
    canvas.drawArc(rect, 0.0, 1.571, false, bluePaint);

    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(width * 0.48, height * 0.38, width * 0.95, height * 0.62),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
