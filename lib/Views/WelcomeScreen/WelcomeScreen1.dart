import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Views/NavigationScreen.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeScreen2.dart';
import 'package:social_app/Views/shared/ColoredButton.dart';
import 'package:social_app/Views/shared/TransparentButton.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

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
            child: Image.asset("assets/images/Welcome1.png"),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () => Get.to(WelcomeScreen2()),
              child: const ColoredButton()),
          InkWell(
              onTap: () => Get.to(NavigationScreen()),
              child: const TransparentButton())
        ],
      ),
    ));
  }
}
