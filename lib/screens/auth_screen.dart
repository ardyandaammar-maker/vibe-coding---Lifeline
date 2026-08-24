import 'package:flutter/material.dart';
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
  String? _errorMessage;

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

  void _submit() {
    setState(() {
      _errorMessage = null;
    });

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    if (_currentMode == AuthMode.register) {
      final name = _fullNameController.text.trim();

      // Check if email already exists
      final bool exists = UserStore().isEmailRegistered(email);
      if (exists) {
        setState(() {
          _errorMessage = 'Email ini sudah terdaftar. Silakan langsung masuk.';
        });
        return;
      }

      // Add new account to central UserStore
      final newAccount = UserAccount(name: name, email: email, password: password);
      UserStore().registerAccount(newAccount);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Pendaftaran berhasil! Silakan masuk dengan email & kata sandi Anda.'),
          backgroundColor: Color(0xFF079455),
        ),
      );

      // Switch to Sign In mode
      setState(() {
        _currentMode = AuthMode.signIn;
        _errorMessage = null;
      });
    } else {
      // Login validation: must match email AND password via UserStore
      final UserAccount? matchedAccount = UserStore().findAccount(email, password);

      if (matchedAccount != null) {
        // Success
        widget.onAuthSuccess(matchedAccount.name);
      } else {
        // Failure
        setState(() {
          _errorMessage = '❌ Email atau kata sandi tidak cocok dengan akun yang didaftarkan!';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Email atau kata sandi salah. Harap periksa kembali!'),
            backgroundColor: Color(0xFFE53935),
          ),
        );
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
                  onPressed: _submit,
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
