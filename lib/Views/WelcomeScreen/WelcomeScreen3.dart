import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Views/LoginScreen/LoginScreen.dart';
import 'package:social_app/Views/NavigationScreen.dart';

import '../shared/ColoredButton.dart';
import '../shared/TransparentButton.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 500,
            child: Image.asset("assets/images/Welcome3.png"),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () => Get.to(LoginScreen()), child: const ColoredButton()),
          InkWell(
              onTap: () => Get.to(LoginScreen()),
              child: const TransparentButton())
        ],
      ),
    ));
  }
}
