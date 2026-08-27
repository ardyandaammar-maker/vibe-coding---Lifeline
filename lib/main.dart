import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/sos_countdown_screen.dart';
import 'screens/sos_active_screen.dart';
import 'screens/onboarding_screen.dart';
import 'data/user_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init: $e');
  }
  await UserStore().init();
  runApp(const LifelineApp());
}

class LifelineApp extends StatefulWidget {
  const LifelineApp({super.key});

  @override
  State<LifelineApp> createState() => _LifelineAppState();
}

class _LifelineAppState extends State<LifelineApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late String _currentRoute;
  AuthMode _authMode = AuthMode.signIn;
  late String _currentUserName;

  @override
  void initState() {
    super.initState();
    final String? activeUser = UserStore().activeUserName;
    if (activeUser != null && activeUser.isNotEmpty) {
      _currentUserName = activeUser;
      if (UserStore().hasCompletedOnboarding(activeUser)) {
        _currentRoute = 'home';
      } else {
        _currentRoute = 'onboarding';
      }
    } else {
      _currentUserName = 'Ammar';
      _currentRoute = 'welcome';
    }
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _navigateToSignIn() {
    setState(() {
      _authMode = AuthMode.signIn;
      _currentRoute = 'auth';
    });
  }

  void _navigateToRegister() {
    setState(() {
      _authMode = AuthMode.register;
      _currentRoute = 'auth';
    });
  }

  void _navigateToHome([String? userName]) {
    setState(() {
      if (userName != null) {
        _currentUserName = userName;
        UserStore().setActiveUser(userName);
      }
      
      if (UserStore().hasCompletedOnboarding(_currentUserName)) {
        _currentRoute = 'home';
      } else {
        _currentRoute = 'onboarding';
      }
    });
  }

  void _navigateToWelcome() {
    UserStore().clearActiveUser();
    setState(() {
      _currentRoute = 'welcome';
    });
  }

  void _navigateToSosCountdown() {
    setState(() {
      _currentRoute = 'sos_countdown';
    });
  }

  void _navigateToSosActive() {
    setState(() {
      _currentRoute = 'sos_active';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = _themeMode == ThemeMode.dark;

    Widget body;
    switch (_currentRoute) {
      case 'auth':
        body = AuthScreen(
          initialMode: _authMode,
          onBackToHome: _navigateToWelcome,
          onAuthSuccess: (userName) => _navigateToHome(userName),
          onToggleTheme: _toggleTheme,
          isDarkMode: isDarkMode,
        );
        break;
      case 'onboarding':
        body = OnboardingScreen(
          userName: _currentUserName,
          onFinish: () {
            setState(() {
              _currentRoute = 'home';
            });
          },
        );
        break;
      case 'home':
        body = HomeScreen(
          userName: _currentUserName,
          onSignOut: _navigateToWelcome,
          onToggleTheme: _toggleTheme,
          onTriggerSos: _navigateToSosCountdown,
          isDarkMode: isDarkMode,
        );
        break;
      case 'sos_countdown':
        body = SosCountdownScreen(
          onCancel: _navigateToHome,
          onCountdownFinished: _navigateToSosActive,
        );
        break;
      case 'sos_active':
        body = SosActiveScreen(
          onEndSos: _navigateToHome,
        );
        break;
      case 'welcome':
      default:
        body = WelcomeScreen(
          onStartRegister: _navigateToRegister,
          onGoSignIn: _navigateToSignIn,
          onToggleTheme: _toggleTheme,
          isDarkMode: isDarkMode,
        );
        break;
    }

    return MaterialApp(
      title: 'Lifeline - Emergency & Health',
      debugShowCheckedModeBanner: false,
      theme: LifelineTheme.lightTheme,
      darkTheme: LifelineTheme.darkTheme,
      themeMode: _themeMode,
      home: body,
    );
  }
}
