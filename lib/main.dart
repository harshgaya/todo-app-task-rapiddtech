import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_rapiddtech/view_models/task_provider.dart';
import 'package:todo_app_rapiddtech/views/edit_task_screen.dart';
import 'package:todo_app_rapiddtech/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_links/uni_links.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        title: 'To do',
      ),
    );
  }
}
