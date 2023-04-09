import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/PrfileController.dart';

import '../../Controllers/AuthenticationService.dart';
import '../shared/ColoredButton.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String date = "";
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();

    void showDatePickerDialog() async {
      var pickedDate = await showDatePicker(
          context: context, //context of current state
          initialDate: DateTime.now(),
          firstDate: DateTime(
              2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101));
      if (pickedDate != null) {
        setState(() {
          date = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
          print(date);
        });
      }
    }

    void selectGender() async {
      setState(() {
        if (gender == "Male") {
          gender = "Female";
        } else {
          gender = "Male";
        }
      });
    }

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
                  "Personal Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: const Text(
                  "Please fill the following",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectImage();
                    },
                    child: Obx(
                      () => Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[300],
                          image: controller.isSelected.value == false
                              ? const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/transparent.png"))
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(controller.image.value)),
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              NewUserTextFeild(
                heading: "Full name",
                controller: controller.fullNameController,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Text(
                              "Date of birth",
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () => showDatePickerDialog(),
                            child: Container(
                              height: 50,
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Text(date.toString()),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_downward,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () => selectGender(),
                            child: Container(
                              height: 50,
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Text(gender),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_downward,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
              BioTextFeild(bioController: controller.bioController),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    if (controller.fullNameController.text.length > 0 &&
                        controller.bioController.text.length > 0 &&
                        date.length > 0) {
                      controller.fullName.value =
                          controller.fullNameController.text;
                      controller.bio.value = controller.bioController.text;
                      controller.dataOfBirth.value = date;
                      controller.gender.value = gender;
                      // Get.to(PasswordSelectorScreen());
                      controller.addUserToFirestore(
                          fullname: controller.fullName.value,
                          username: controller.username.value,
                          dateOfBirth: controller.dataOfBirth.value,
                          gender: controller.gender.value,
                          bio: controller.bio.value,
                          profilePhoto: "");
                      Get.back();
                    } else {
                      Get.snackbar("Error", "Fill all the details");
                    }
                  },
                  child: const ColoredButton())
            ],
          ),
        ));
  }
}

class BioTextFeild extends StatelessWidget {
  const BioTextFeild({
    super.key,
    required this.bioController,
  });

  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Bio",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 130.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: bioController,
              decoration: const InputDecoration(
                hintText: 'Enter your bio',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
        ],
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
                hintText: 'Enter $heading',
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
