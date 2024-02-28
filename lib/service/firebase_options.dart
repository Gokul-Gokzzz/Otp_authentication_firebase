// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyC3khM9wPYGoz7yzdqfA3aSDh0mLfa28A4',
    appId: '1:1018911373199:web:5bd880837e7220323bfdfa',
    messagingSenderId: '1018911373199',
    projectId: 'phoneauth-6c46c',
    authDomain: 'phoneauth-6c46c.firebaseapp.com',
    storageBucket: 'phoneauth-6c46c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbea0v1naZDh8CGe1TQLCPOCm5MSuReos',
    appId: '1:1018911373199:android:7c63ebb2ada135773bfdfa',
    messagingSenderId: '1018911373199',
    projectId: 'phoneauth-6c46c',
    storageBucket: 'phoneauth-6c46c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIIuErGzT-e2ee5fOmkvEsCRTX-NGUzBs',
    appId: '1:1018911373199:ios:636704ddc1d8bad53bfdfa',
    messagingSenderId: '1018911373199',
    projectId: 'phoneauth-6c46c',
    storageBucket: 'phoneauth-6c46c.appspot.com',
    iosBundleId: 'com.example.authentication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIIuErGzT-e2ee5fOmkvEsCRTX-NGUzBs',
    appId: '1:1018911373199:ios:2eef82d8b994476c3bfdfa',
    messagingSenderId: '1018911373199',
    projectId: 'phoneauth-6c46c',
    storageBucket: 'phoneauth-6c46c.appspot.com',
    iosBundleId: 'com.example.authentication.RunnerTests',
  );
}
