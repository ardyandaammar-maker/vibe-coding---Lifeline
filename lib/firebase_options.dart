// File generated for Lifeline App Firebase initialization.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUOyM-JkOfhJTIwa41N4YFJYBGXG9Uy2g',
    appId: '1:633261118229:web:055f79513f2bdbcf174f1c',
    messagingSenderId: '633261118229',
    projectId: 'lifeline-emergency-health',
    authDomain: 'lifeline-emergency-health.firebaseapp.com',
    storageBucket: 'lifeline-emergency-health.firebasestorage.app',
    measurementId: 'G-8QZPQN7DG0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbImHJWdQDnMpJs2SLmdhX2cwLtgb3-t4',
    appId: '1:633261118229:android:11db41f7294cbb07174f1c',
    messagingSenderId: '633261118229',
    projectId: 'lifeline-emergency-health',
    storageBucket: 'lifeline-emergency-health.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyForLifelineAppDemo12345',
    appId: '1:123456789012:ios:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'lifeline-emergency-health',
    storageBucket: 'lifeline-emergency-health.appspot.com',
    iosBundleId: 'com.example.lifeline',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyForLifelineAppDemo12345',
    appId: '1:123456789012:ios:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'lifeline-emergency-health',
    storageBucket: 'lifeline-emergency-health.appspot.com',
    iosBundleId: 'com.example.lifeline',
  );
}
