import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Views/AuthenticationScreen/AuthenticationScreen.dart';
import 'package:social_app/Views/HomeScreen.dart';
import 'package:social_app/Views/NavigationScreen.dart';
import 'package:social_app/Views/NewUserScreen/NewUserScreen.dart';
import 'package:social_app/Views/NewUserScreen/PasswordSelector.dart';
import 'package:social_app/Views/WelcomeScreen/SplashScreen.dart';

import 'Services/firebase_options.dart';

void main() async {
  await GetStorage.init();
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
    final prefs = GetStorage();
    var userId = prefs.read('user_id');
    print(userId);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      theme: ThemeData(primaryColor: Color(0xff1C6758)),
      home: userId != null ? NavigationScreen() : AuthenticationScreen(),
    );
  }
}
