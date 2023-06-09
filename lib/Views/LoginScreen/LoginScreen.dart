import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:social_app/Controllers/AuthenticationService.dart';
import 'package:social_app/Views/shared/ColoredButton.dart';

import '../AuthenticationScreen/OTPScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    TextEditingController phoneController = TextEditingController();
    String phoneNumber = '';
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
                    controller: phoneController,
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
                      print(phone.completeNumber);
                      phoneNumber = phone.completeNumber;
                    },
                    onSubmitted: (value) {
                      submitPhoen(phoneNumber, controller);
                    },
                  )),
              // Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.44,
              ),
              GestureDetector(
                  onTap: () {
                    print("ccccccccccccccccccccccccccccccc");
                    print(phoneNumber);
                    submitPhoen(phoneNumber, controller);
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
        ));
  }

  void submitPhoen(String phoneNumber, AuthController controller) {
    print(phoneNumber);
    if (phoneNumber.length >= 12) {
      controller.signUpWithPhoneNumber(phoneNumber);
      Get.to(OTPScreen());
    } else {
      Get.snackbar("Error", "Enter a valid number");
    }
  }
}
