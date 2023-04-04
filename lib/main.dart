import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Views/NavigationScreen.dart';

import 'Services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      home: NavigationScreen(),
    );
  }
}
