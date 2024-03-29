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
    apiKey: 'AIzaSyAc42PhaY8Fg_gx323u_1I0qxaVnH6ty0Q',
    appId: '1:808963225547:web:fc021a0ec4faa8dc8fa84e',
    messagingSenderId: '808963225547',
    projectId: 'todo-task-rapiddtech',
    authDomain: 'todo-task-rapiddtech.firebaseapp.com',
    storageBucket: 'todo-task-rapiddtech.appspot.com',
    measurementId: 'G-Z7CJSQ0TT1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALTmB-b8tCpmNlBNEbJitUhgtZ9s3XWSY',
    appId: '1:808963225547:android:20ef46fd2ee5a1768fa84e',
    messagingSenderId: '808963225547',
    projectId: 'todo-task-rapiddtech',
    storageBucket: 'todo-task-rapiddtech.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5IhYU5t2-oAsDSRMMroJbY-jP037YJKg',
    appId: '1:808963225547:ios:dff9a0349e06cb4e8fa84e',
    messagingSenderId: '808963225547',
    projectId: 'todo-task-rapiddtech',
    storageBucket: 'todo-task-rapiddtech.appspot.com',
    iosBundleId: 'com.example.todoAppRapiddtech',
  );
}
