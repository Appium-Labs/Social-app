import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Views/NavigationScreen.dart';
import 'package:social_app/Views/shared/ColoredButton.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
                margin: const EdgeInsets.only(left: 30),
                child: Image.asset("assets/images/WelcomeBack.png")),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => Get.offAll(NavigationScreen()),
              child: const ColoredButton(),
            )
          ],
        ),
      ),
    );
  }
}
