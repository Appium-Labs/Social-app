import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/Services/AuthenticationService.dart';
import 'package:social_app/Views/LoginScreen/OTPTextFeild.dart';

import '../shared/ColoredButton.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    final TextEditingController _firstController = TextEditingController();
    final TextEditingController _secondController = TextEditingController();
    final TextEditingController _thirdController = TextEditingController();
    final TextEditingController _fourthController = TextEditingController();
    final TextEditingController _fifthController = TextEditingController();
    final TextEditingController _sixthController = TextEditingController();
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
      body: Obx(
        () => controller.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff1C6758),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: const Text(
                        "OTP sent",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                      fourthController: _fourthController,
                      fifthController: _fifthController,
                      sixthController: _sixthController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.47,
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.verifyOTP(_firstController.text +
                              _secondController.text +
                              _thirdController.text +
                              _fourthController.text +
                              _fifthController.text +
                              _sixthController.text);
                        },
                        child: const ColoredButton()),
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
      ),
    );
  }
}
