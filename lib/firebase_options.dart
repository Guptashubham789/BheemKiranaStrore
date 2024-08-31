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
        return ios;
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
    apiKey: 'AIzaSyBn24uUzCDzn5tNsoC8DvAe77pKw3LwswU',
    appId: '1:932326116836:web:f1d9553f4986fc36bf0bf1',
    messagingSenderId: '932326116836',
    projectId: 'groceryapp-70272',
    authDomain: 'groceryapp-70272.firebaseapp.com',
    storageBucket: 'groceryapp-70272.appspot.com',
    measurementId: 'G-9F1B0HHT74',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIdwxBAQodfVnE5DvlepYAmPj2EQP2NRI',
    appId: '1:932326116836:android:24f7e91457fa8df8bf0bf1',
    messagingSenderId: '932326116836',
    projectId: 'groceryapp-70272',
    storageBucket: 'groceryapp-70272.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzvWecvtQhaDyPYq0eO63dpNuBCqtcxTY',
    appId: '1:932326116836:ios:6295fc77a329ed46bf0bf1',
    messagingSenderId: '932326116836',
    projectId: 'groceryapp-70272',
    storageBucket: 'groceryapp-70272.appspot.com',
    iosBundleId: 'com.example.groceryapp',
  );
}
