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
    apiKey: 'AIzaSyATrcVmulhrWZLAuQhPIkTevo95Kx5rP1s',
    appId: '1:84066150391:web:c16cd9bce7726d0b4430f2',
    messagingSenderId: '84066150391',
    projectId: 'doggy-date-app',
    authDomain: 'doggy-date-app.firebaseapp.com',
    storageBucket: 'doggy-date-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh93wLDHkHi3z0HfJdpqPXFnobyTTH0VE',
    appId: '1:84066150391:android:d02b7968bad3497a4430f2',
    messagingSenderId: '84066150391',
    projectId: 'doggy-date-app',
    storageBucket: 'doggy-date-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBd62_MG1eDnoXXtnm7ROsio-sJF7CIUBk',
    appId: '1:84066150391:ios:8a5b70ede42be4bb4430f2',
    messagingSenderId: '84066150391',
    projectId: 'doggy-date-app',
    storageBucket: 'doggy-date-app.appspot.com',
    iosClientId: '84066150391-h46cocv36v0ba6up82lbq6q138o19t43.apps.googleusercontent.com',
    iosBundleId: 'com.example.doggyDate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBd62_MG1eDnoXXtnm7ROsio-sJF7CIUBk',
    appId: '1:84066150391:ios:8a5b70ede42be4bb4430f2',
    messagingSenderId: '84066150391',
    projectId: 'doggy-date-app',
    storageBucket: 'doggy-date-app.appspot.com',
    iosClientId: '84066150391-h46cocv36v0ba6up82lbq6q138o19t43.apps.googleusercontent.com',
    iosBundleId: 'com.example.doggyDate',
  );
}
