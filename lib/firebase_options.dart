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
    apiKey: 'AIzaSyB6SD90jFg5TnYXVNufRte-gD8_-b3p-d8',
    appId: '1:228411321888:web:a869597852bf64205f1645',
    messagingSenderId: '228411321888',
    projectId: 'dd-study-22-5daa6',
    authDomain: 'dd-study-22-5daa6.firebaseapp.com',
    storageBucket: 'dd-study-22-5daa6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwqNC6CyJVT0AEx5Iq16cywANGKFOeocw',
    appId: '1:228411321888:android:12a7b4d18c48af175f1645',
    messagingSenderId: '228411321888',
    projectId: 'dd-study-22-5daa6',
    storageBucket: 'dd-study-22-5daa6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq08oXfrtya2vwHzuDya3MxL6VyVA3B4I',
    appId: '1:228411321888:ios:07db6495509b8ef15f1645',
    messagingSenderId: '228411321888',
    projectId: 'dd-study-22-5daa6',
    storageBucket: 'dd-study-22-5daa6.appspot.com',
    iosClientId:
        '228411321888-0fhafbggskfubg8up2u75qucuih29hvn.apps.googleusercontent.com',
    iosBundleId: 'com.example.ddStudy22Ui',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAq08oXfrtya2vwHzuDya3MxL6VyVA3B4I',
    appId: '1:228411321888:ios:07db6495509b8ef15f1645',
    messagingSenderId: '228411321888',
    projectId: 'dd-study-22-5daa6',
    storageBucket: 'dd-study-22-5daa6.appspot.com',
    iosClientId:
        '228411321888-0fhafbggskfubg8up2u75qucuih29hvn.apps.googleusercontent.com',
    iosBundleId: 'com.example.ddStudy22Ui',
  );
}
