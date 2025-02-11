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
    apiKey: 'AIzaSyA92frgS0l16vZxxm2VcOybb7fYIOLjv8M',
    appId: '1:70456384620:web:fcf5d0dc108532d8bdcc49',
    messagingSenderId: '70456384620',
    projectId: 'moneypot-e90dc',
    authDomain: 'moneypot-e90dc.firebaseapp.com',
    storageBucket: 'moneypot-e90dc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjyB-dt02wVc9VN3RdDgyORA-PnTDRUp8',
    appId: '1:70456384620:android:125ab722345e14eabdcc49',
    messagingSenderId: '70456384620',
    projectId: 'moneypot-e90dc',
    storageBucket: 'moneypot-e90dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBACcbdRaBSz-KejCy3HiAjnSEbCj1fRDg',
    appId: '1:70456384620:ios:86f1b93975d40a9cbdcc49',
    messagingSenderId: '70456384620',
    projectId: 'moneypot-e90dc',
    storageBucket: 'moneypot-e90dc.appspot.com',
    iosBundleId: 'com.sai.moneyPot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBACcbdRaBSz-KejCy3HiAjnSEbCj1fRDg',
    appId: '1:70456384620:ios:52e501d9cfe0d589bdcc49',
    messagingSenderId: '70456384620',
    projectId: 'moneypot-e90dc',
    storageBucket: 'moneypot-e90dc.appspot.com',
    iosBundleId: 'com.sai.moneyPot.RunnerTests',
  );
}
