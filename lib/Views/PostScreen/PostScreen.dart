import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/PostScreenController.dart';
import 'package:social_app/Controllers/PrfileController.dart';
import 'package:social_app/Views/PostScreen/Components.dart';

class PostScreen extends StatelessWidget {
  final postController = Get.put(PostScreenController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
          backgroundColor: appBgColor,
          centerTitle: true,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
          title: const Text(
            "Post",
            style: TextStyle(color: primaryTextColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(27),
          child: Obx(
            () => Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Image",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: postController.isSelected.value == false
                              ? const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/transparent.png"))
                              : DecorationImage(
                                  fit: BoxFit.contain,
                                  image:
                                      MemoryImage(postController.image.value)),
                          color: textFieldColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: postController.isSelected.value == true
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  postController.selectImage();
                                },
                                child: const Icon(
                                  Icons.add_circle_rounded,
                                  color: greenColor,
                                ))),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                TextInputField("Add caption", postController.captionController),
                const SizedBox(
                  height: 36,
                ),
                postController.isImageUploading.value == true
                    ? const CircularProgressIndicator(
                        color: greenColor,
                      )
                    : InkWell(
                        onTap: () {
                          // print(captionContr/oller.text);
                          postController.uploadPost(
                              postController.captionController.text);
                          profileController.onInit();
                        },
                        child: primaryButton("Upload")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
