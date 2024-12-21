// File generated by FlutterFire CLI.
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDoLHGOmNbWV-Nf1AO24HuACaPzMY5Ruh8',
    appId: '1:919723291873:web:e5b27b6a1612402c0e33a0',
    messagingSenderId: '919723291873',
    projectId: 'rentalhome-a1380',
    authDomain: 'rentalhome-a1380.firebaseapp.com',
    databaseURL: 'https://rentalhome-a1380-default-rtdb.firebaseio.com',
    storageBucket: 'rentalhome-a1380.firebasestorage.app',
    measurementId: 'G-H6ZXDW1JE2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmTSGbJEjdeq2hUVbao5EMKSCAbpGrZ9A',
    appId: '1:919723291873:android:ae9e6cb246cc66570e33a0',
    messagingSenderId: '919723291873',
    projectId: 'rentalhome-a1380',
    databaseURL: 'https://rentalhome-a1380-default-rtdb.firebaseio.com',
    storageBucket: 'rentalhome-a1380.firebasestorage.app',
  );
}
