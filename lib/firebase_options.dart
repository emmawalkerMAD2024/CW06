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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCzSJtUen4x2ma97tn2cs8ULmG7BTlePM4',
    appId: '1:80665656564:web:2c1efa268ebe3bab60f2a1',
    messagingSenderId: '80665656564',
    projectId: 'feefee-b86b6',
    authDomain: 'feefee-b86b6.firebaseapp.com',
    storageBucket: 'feefee-b86b6.firebasestorage.app',
    measurementId: 'G-V9984NEJPC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcxs5X7LehQzFpuLMisfAe8_zUPeDxFdk',
    appId: '1:80665656564:android:976767b5bf2140c660f2a1',
    messagingSenderId: '80665656564',
    projectId: 'feefee-b86b6',
    storageBucket: 'feefee-b86b6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNBXt8KNb_Fc92upM8GO8rUJpANUEzj0c',
    appId: '1:80665656564:ios:0bc2e796f3da05e760f2a1',
    messagingSenderId: '80665656564',
    projectId: 'feefee-b86b6',
    storageBucket: 'feefee-b86b6.firebasestorage.app',
    iosBundleId: 'com.example.cw06Taskmanager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNBXt8KNb_Fc92upM8GO8rUJpANUEzj0c',
    appId: '1:80665656564:ios:0bc2e796f3da05e760f2a1',
    messagingSenderId: '80665656564',
    projectId: 'feefee-b86b6',
    storageBucket: 'feefee-b86b6.firebasestorage.app',
    iosBundleId: 'com.example.cw06Taskmanager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCzSJtUen4x2ma97tn2cs8ULmG7BTlePM4',
    appId: '1:80665656564:web:866c3d096ff367ad60f2a1',
    messagingSenderId: '80665656564',
    projectId: 'feefee-b86b6',
    authDomain: 'feefee-b86b6.firebaseapp.com',
    storageBucket: 'feefee-b86b6.firebasestorage.app',
    measurementId: 'G-77QK8HJH9L',
  );
}
