import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:social_app/Views/AuthenticationScreen/OTPScreen.dart';
import 'package:social_app/Controllers/AuthenticationService.dart';

import '../shared/ColoredButton.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
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
                "Phone",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    controller.phoneNumber.value = phone.completeNumber;
                  },
                  onSubmitted: (value) {
                    print(controller.phoneNumber.value);
                  },
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.44,
            ),
            GestureDetector(
                onTap: () {
                  if (controller.phoneNumber.value.length >= 13) {
                    // Get.to(OTPScreen());
                    controller
                        .signUpWithPhoneNumber(controller.phoneNumber.value)
                        .then((value) {
                      if (value) {
                        Get.to(OTPScreen());
                      } else {
                        Get.rawSnackbar(
                            title: "Error",
                            message: "Error Signing in try again");
                      }
                    });
                  } else {
                    Get.rawSnackbar(
                        title: "Error", message: "Enter a valid number");
                  }
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
    );
  }
}
