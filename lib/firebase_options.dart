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
    apiKey: 'AIzaSyAXzCus0YQ8tXdGboMJM9xEyIVIJzNqU54',
    appId: '1:593289067235:web:bda820ee659123edcd23d6',
    messagingSenderId: '593289067235',
    projectId: 'fitappfirebase',
    authDomain: 'fitappfirebase.firebaseapp.com',
    databaseURL: 'https://fitappfirebase-default-rtdb.firebaseio.com',
    storageBucket: 'fitappfirebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3OeNuCQcCsuYaFH3ZpdfOftQzP1RZSB0',
    appId: '1:593289067235:android:cc2c6fb9c467956dcd23d6',
    messagingSenderId: '593289067235',
    projectId: 'fitappfirebase',
    databaseURL: 'https://fitappfirebase-default-rtdb.firebaseio.com',
    storageBucket: 'fitappfirebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmhBjr9JDZ6X1CuuFc5dvepzEQPPvOpMA',
    appId: '1:593289067235:ios:963e13b178d91959cd23d6',
    messagingSenderId: '593289067235',
    projectId: 'fitappfirebase',
    databaseURL: 'https://fitappfirebase-default-rtdb.firebaseio.com',
    storageBucket: 'fitappfirebase.appspot.com',
    androidClientId: '593289067235-4ogu4oqr21cl921ro3ahiffl5rm6lbjo.apps.googleusercontent.com',
    iosClientId: '593289067235-2gdjl941mi9r52bdkl6149khmu1c64k6.apps.googleusercontent.com',
    iosBundleId: 'com.example.firstApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmhBjr9JDZ6X1CuuFc5dvepzEQPPvOpMA',
    appId: '1:593289067235:ios:963e13b178d91959cd23d6',
    messagingSenderId: '593289067235',
    projectId: 'fitappfirebase',
    databaseURL: 'https://fitappfirebase-default-rtdb.firebaseio.com',
    storageBucket: 'fitappfirebase.appspot.com',
    androidClientId: '593289067235-4ogu4oqr21cl921ro3ahiffl5rm6lbjo.apps.googleusercontent.com',
    iosClientId: '593289067235-2gdjl941mi9r52bdkl6149khmu1c64k6.apps.googleusercontent.com',
    iosBundleId: 'com.example.firstApp',
  );
}
