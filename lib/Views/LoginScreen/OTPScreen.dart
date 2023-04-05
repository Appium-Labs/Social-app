import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Views/LoginScreen/OTPTextFeild.dart';

import '../shared/ColoredButton.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstController = TextEditingController();
    final TextEditingController _secondController = TextEditingController();
    final TextEditingController _thirdController = TextEditingController();
    final TextEditingController _fourthController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                "OTP sent",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                "Enter the OTP sent to you",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OTPTextFeild(
                firstController: _firstController,
                secondController: _secondController,
                thirdController: _thirdController,
                fourthController: _fourthController),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
            ),
            GestureDetector(
                onTap: () => Get.to(OTPScreen()), child: const ColoredButton()),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an accouunt?",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    " Sign-in",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
