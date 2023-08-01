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
    apiKey: 'AIzaSyAeDInVBtBiIzsI8t_XYrYKLhnQ_uxhcp0',
    appId: '1:455611953839:web:44a4347c947b73867c5a5a',
    messagingSenderId: '455611953839',
    projectId: 'plantazul',
    authDomain: 'plantazul.firebaseapp.com',
    databaseURL: 'https://plantazul-default-rtdb.firebaseio.com',
    storageBucket: 'plantazul.appspot.com',
    measurementId: 'G-SSVJ3LE977',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn5kQq0rCRH5uCj5V5hRIRuaWorEEQ_hM',
    appId: '1:455611953839:android:6084c5434a3b7e4b7c5a5a',
    messagingSenderId: '455611953839',
    projectId: 'plantazul',
    databaseURL: 'https://plantazul-default-rtdb.firebaseio.com',
    storageBucket: 'plantazul.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCL8ZsH7pMwr4Fxj1ZlkKi2HYFJbd5l2b4',
    appId: '1:455611953839:ios:49293c23cfbbde577c5a5a',
    messagingSenderId: '455611953839',
    projectId: 'plantazul',
    databaseURL: 'https://plantazul-default-rtdb.firebaseio.com',
    storageBucket: 'plantazul.appspot.com',
    iosClientId: '455611953839-14la695b4i2ubulj160cj0mjos2jf94c.apps.googleusercontent.com',
    iosBundleId: 'com.example.productosApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCL8ZsH7pMwr4Fxj1ZlkKi2HYFJbd5l2b4',
    appId: '1:455611953839:ios:abefd02f71b471ba7c5a5a',
    messagingSenderId: '455611953839',
    projectId: 'plantazul',
    databaseURL: 'https://plantazul-default-rtdb.firebaseio.com',
    storageBucket: 'plantazul.appspot.com',
    iosClientId: '455611953839-r4rsreeppqq0ek57mts5aob6cp168ejq.apps.googleusercontent.com',
    iosBundleId: 'com.example.productosApp.RunnerTests',
  );
}
