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
    apiKey: 'AIzaSyA6jlSx3LX1UO_cxfE0ULvI7TzF2hBN2jI',
    appId: '1:776262559042:web:59a55dfd6185327cb8d4db',
    messagingSenderId: '776262559042',
    projectId: 'instagram-74ce5',
    authDomain: 'instagram-74ce5.firebaseapp.com',
    storageBucket: 'instagram-74ce5.appspot.com',
    measurementId: 'G-DXM8MNLZ62',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0z-AF8lvwVIJDtMSb0d97heHwLPNAd9E',
    appId: '1:776262559042:android:6918b1f593277fa6b8d4db',
    messagingSenderId: '776262559042',
    projectId: 'instagram-74ce5',
    storageBucket: 'instagram-74ce5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOqC1YLGHytZLDeiLz_oCxcqwPVpybAEU',
    appId: '1:776262559042:ios:00b6401cc1fa7935b8d4db',
    messagingSenderId: '776262559042',
    projectId: 'instagram-74ce5',
    storageBucket: 'instagram-74ce5.appspot.com',
    iosClientId: '776262559042-plsvf3s4f4fr1pkh50590ui3ecna8j65.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOqC1YLGHytZLDeiLz_oCxcqwPVpybAEU',
    appId: '1:776262559042:ios:6c7f24201e63c1f1b8d4db',
    messagingSenderId: '776262559042',
    projectId: 'instagram-74ce5',
    storageBucket: 'instagram-74ce5.appspot.com',
    iosClientId: '776262559042-2vclvob4b3o6s7ct4vrk92dqse1uod3v.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramFlutter.RunnerTests',
  );
}
