import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Services/AuthenticationService.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeBackScreen.dart';
import 'package:social_app/Views/shared/ColoredButton.dart';

class PasswordSelectorScreen extends StatelessWidget {
  const PasswordSelectorScreen({super.key});

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
                "Set a username",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                "Help secure your account",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            NewUserTextFeild(
                controller: controller.usernameController, heading: "Username"),
            const SizedBox(
              height: 10,
            ),
            NewUserTextFeild(
                controller: controller.passwordController, heading: "Password"),
            const SizedBox(
              height: 10,
            ),
            NewUserTextFeild(
                controller: controller.confirmPasswordController,
                heading: "Confirm Password"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            GestureDetector(
              onTap: () {
                if (controller.passwordController.text.length > 0 &&
                    controller.passwordController.text ==
                        controller.confirmPasswordController.text &&
                    controller.usernameController.text.length > 0) {
                  controller.username.value =
                      controller.usernameController.text;
                  controller.password.value =
                      controller.passwordController.text;
                  controller.addUserToFirestore(
                      fullname: controller.fullName.value,
                      username: controller.username.value,
                      email: controller.email.value,
                      password: controller.password.value,
                      dateOfBirth: controller.dataOfBirth.value,
                      gender: controller.gender.value,
                      bio: controller.bio.value,
                      profilePhoto: "");
                  Get.to(WelcomeBackScreen());
                } else {
                  Get.snackbar("Error", "Fill all the details correctluy");
                }
              },
              child: ColoredButton(),
            )
          ],
        ),
      ),
    );
  }
}

class NewUserTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String heading;
  const NewUserTextFeild(
      {super.key, required this.controller, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter ' + heading,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
