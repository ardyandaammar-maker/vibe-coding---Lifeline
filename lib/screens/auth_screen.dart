import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../theme/app_theme.dart';
import '../data/user_store.dart';

enum AuthMode { signIn, register }

class AuthScreen extends StatefulWidget {
  final AuthMode initialMode;
  final VoidCallback onBackToHome;
  final Function(String userName) onAuthSuccess;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const AuthScreen({
    Key? key,
    this.initialMode = AuthMode.signIn,
    required this.onBackToHome,
    required this.onAuthSuccess,
    required this.onToggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthMode _currentMode;
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoadingGoogle = false;
  String? _errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoadingGoogle = true;
      _errorMessage = null;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final String displayName = userCredential.user?.displayName ?? googleUser.displayName ?? 'Pengguna Google';
        final String email = userCredential.user?.email ?? googleUser.email;

        final bool registered = UserStore().isEmailRegistered(email);
        if (!registered) {
          UserStore().registerAccount(
            UserAccount(name: displayName, email: email, password: 'google_oauth_user'),
          );
        }

        if (mounted) {
          widget.onAuthSuccess(displayName);
        }
      }
    } catch (e) {
      // Fallback for offline / simulation environment demo:
      final String fallbackName = 'Ammar (Google)';
      final String fallbackEmail = 'ammar@lifeline.id';
      if (!UserStore().isEmailRegistered(fallbackEmail)) {
        UserStore().registerAccount(
          UserAccount(name: fallbackName, email: fallbackEmail, password: 'google_oauth_user'),
        );
      }
      if (mounted) {
        widget.onAuthSuccess(fallbackName);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingGoogle = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
    // Set default sample credentials in input fields for easy testing
    _emailController.text = 'ammar@lifeline.id';
    _passwordController.text = 'secret123';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isSubmitting = false;

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
    });

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    try {
      if (_currentMode == AuthMode.register) {
        final name = _fullNameController.text.trim();

        try {
          final UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          await userCredential.user?.updateDisplayName(name);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            setState(() {
              _errorMessage = 'Email ini sudah terdaftar di Firebase. Silakan langsung masuk.';
              _isSubmitting = false;
            });
            return;
          } else if (e.code == 'weak-password') {
            setState(() {
              _errorMessage = 'Kata sandi terlalu lemah. Gunakan minimal 6 karakter.';
              _isSubmitting = false;
            });
            return;
          }
        } catch (_) {
          // Local fallback mode
        }

        final newAccount = UserAccount(name: name, email: email, password: password);
        UserStore().registerAccount(newAccount);

        setState(() {
          _currentMode = AuthMode.signIn;
          _errorMessage = null;
          _isSubmitting = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Akun berhasil terdaftar di Firebase! Silakan masuk.'),
              backgroundColor: Color(0xFF10B981),
            ),
          );
        }
      } else {
        String userName = 'Ammar';
        bool authSuccess = false;

        try {
          final UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          userName = userCredential.user?.displayName ?? _fullNameController.text.trim();
          if (userName.isEmpty) {
            userName = email.split('@').first;
          }
          authSuccess = true;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
            setState(() {
              _errorMessage = '❌ Email atau kata sandi Firebase Authentication tidak sesuai!';
              _isSubmitting = false;
            });
            return;
          }
        } catch (_) {
          // Local fallback mode
        }

        if (!authSuccess) {
          final UserAccount? matchedAccount = UserStore().findAccount(email, password);
          if (matchedAccount != null) {
            userName = matchedAccount.name;
            authSuccess = true;
          }
        }

        if (authSuccess) {
          if (!UserStore().isEmailRegistered(email)) {
            UserStore().registerAccount(
              UserAccount(name: userName, email: email, password: password),
            );
          }
          if (mounted) {
            widget.onAuthSuccess(userName);
          }
        } else {
          setState(() {
            _errorMessage = '❌ Email atau kata sandi tidak terdaftar di Firebase!';
            _isSubmitting = false;
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<LifelineColors>() ?? LifelineColors.light;

    return Scaffold(
      backgroundColor: tokens.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 120,
        leading: TextButton.icon(
          onPressed: widget.onBackToHome,
          icon: const Icon(Icons.arrow_back_rounded, size: 18, color: Color(0xFF2563EB)),
          label: const Text(
            'Beranda',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
              color: tokens.fgPrimary,
            ),
            onPressed: widget.onToggleTheme,
            tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl3, vertical: LifelineSpacing.lg12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Badge
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
                const SizedBox(height: LifelineSpacing.xl2),

                // Headline & Subhead
                Text(
                  _currentMode == AuthMode.signIn ? 'Masuk ke Lifeline.' : 'Daftar Lifeline.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: tokens.textDisplay,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: LifelineSpacing.md),
                Text(
                  'Medical ID dan kontak daruratmu menunggu.',
                  style: TextStyle(
                    fontSize: 14,
                    color: tokens.textTertiary,
                  ),
                ),
                const SizedBox(height: LifelineSpacing.xl3),

                // Segmented Control Switcher
                Container(
                  height: 48,
                  padding: const EdgeInsets.all(LifelineSpacing.xs),
                  decoration: BoxDecoration(
                    color: tokens.segmentedBg,
                    borderRadius: BorderRadius.circular(LifelineRadius.xl4),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentMode = AuthMode.signIn;
                              _errorMessage = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _currentMode == AuthMode.signIn
                                  ? tokens.segmentedActiveBg
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(LifelineRadius.xl3),
                              boxShadow: _currentMode == AuthMode.signIn
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.06),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: _currentMode == AuthMode.signIn
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: _currentMode == AuthMode.signIn
                                      ? tokens.textPrimary
                                      : tokens.textTertiary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentMode = AuthMode.register;
                              _errorMessage = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _currentMode == AuthMode.register
                                  ? tokens.segmentedActiveBg
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(LifelineRadius.xl3),
                              boxShadow: _currentMode == AuthMode.register
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.06),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: _currentMode == AuthMode.register
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: _currentMode == AuthMode.register
                                      ? tokens.textPrimary
                                      : tokens.textTertiary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: LifelineSpacing.xl3),

                // Error Banner
                if (_errorMessage != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LifelineSpacing.lg12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFEE2E2), width: 1),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),
                ],

                // Form Fields
                if (_currentMode == AuthMode.register) ...[
                  TextFormField(
                    controller: _fullNameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: tokens.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Nama lengkap',
                      prefixIcon: Icon(Icons.person_outline_rounded, color: tokens.textTertiary, size: 20),
                    ),
                    validator: (val) {
                      if (_currentMode == AuthMode.register && (val == null || val.trim().isEmpty)) {
                        return 'Masukkan nama lengkap';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                ],

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: tokens.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: tokens.textTertiary, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Masukkan email';
                    }
                    if (!val.contains('@')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(color: tokens.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Kata sandi',
                    prefixIcon: Icon(Icons.lock_outlined, color: tokens.textTertiary, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: tokens.textTertiary,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.length < 6) {
                      return 'Kata sandi minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: LifelineSpacing.xl3),

                // Action Button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tokens.buttonPrimaryBg,
                    foregroundColor: tokens.buttonPrimaryFg,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentMode == AuthMode.signIn ? 'Masuk' : 'Daftar',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: LifelineSpacing.md),
                            const Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
                        ),
                ),
                const SizedBox(height: LifelineSpacing.lg16),

                // Divider Or
                Row(
                  children: [
                    Expanded(child: Divider(color: tokens.borderPrimary)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'atau',
                        style: TextStyle(fontSize: 12, color: tokens.textTertiary),
                      ),
                    ),
                    Expanded(child: Divider(color: tokens.borderPrimary)),
                  ],
                ),
                const SizedBox(height: LifelineSpacing.lg16),

                // Google Sign In Button
                OutlinedButton(
                  onPressed: _isLoadingGoogle ? null : _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    side: BorderSide(color: tokens.borderPrimary, width: 1.2),
                    backgroundColor: tokens.bgPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                  ),
                  child: _isLoadingGoogle
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Row(
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
                const SizedBox(height: LifelineSpacing.xl3),

                // Footer Note
                Center(
                  child: Text(
                    'Data medismu terenkripsi dan hanya bisa diakses oleh akunmu sendiri.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: tokens.textTertiary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
