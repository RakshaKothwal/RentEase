import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAwO_2Qed8pplZ5P-12gcyjI024et0OqP8',
    appId: '1:201060654786:web:44f345866b4bc7ad71255b',
    messagingSenderId: '201060654786',
    projectId: 'rentease-c40c7',
    authDomain: 'rentease-c40c7.firebaseapp.com',
    storageBucket: 'rentease-c40c7.firebasestorage.app',
    measurementId: 'G-HC62K4TXMC',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_uYr4Cvur8wVh0sbl2sSOpM7opryNhyY',
    appId: '1:201060654786:ios:4b77894537aa66a271255b',
    messagingSenderId: '201060654786',
    projectId: 'rentease-c40c7',
    storageBucket: 'rentease-c40c7.firebasestorage.app',
    iosBundleId: 'com.example.rentease',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwO_2Qed8pplZ5P-12gcyjI024et0OqP8',
    appId: '1:201060654786:web:5c623e14035ee72671255b',
    messagingSenderId: '201060654786',
    projectId: 'rentease-c40c7',
    authDomain: 'rentease-c40c7.firebaseapp.com',
    storageBucket: 'rentease-c40c7.firebasestorage.app',
    measurementId: 'G-MGD7L8C4E7',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_uYr4Cvur8wVh0sbl2sSOpM7opryNhyY',
    appId: '1:201060654786:ios:4b77894537aa66a271255b',
    messagingSenderId: '201060654786',
    projectId: 'rentease-c40c7',
    storageBucket: 'rentease-c40c7.firebasestorage.app',
    iosBundleId: 'com.example.rentease',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7W4Nmvmu3STyNnkaY2r-zkrEzip3bR_g',
    appId: '1:201060654786:android:daba639180045c9571255b',
    messagingSenderId: '201060654786',
    projectId: 'rentease-c40c7',
    storageBucket: 'rentease-c40c7.firebasestorage.app',
  );
}
