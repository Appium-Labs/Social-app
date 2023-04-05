import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeScreen3.dart';

import '../NavigationScreen.dart';
import '../shared/ColoredButton.dart';
import '../shared/TransparentButton.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

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
            child: Image.asset("assets/images/Welcome2.png"),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () => Get.to(WelcomeScreen3()),
              child: const ColoredButton()),
          InkWell(
              onTap: () => Get.to(NavigationScreen()),
              child: const TransparentButton())
        ],
      ),
    ));
  }
}
