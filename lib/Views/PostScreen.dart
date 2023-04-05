import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/PostScreenController.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostScreenController());
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
          child: Column(
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
                  Obx(
                    () => Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: textFieldColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: postController.isSelected.value == false
                            ? GestureDetector(
                                onTap: () {
                                  postController.selectImage();
                                },
                                child: const Icon(Icons.add_circle_outline))
                            : Image(
                                image: MemoryImage(postController.image.value),
                              )),
                  ),
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              TextInputField("Add caption"),
              const SizedBox(
                height: 36,
              ),
              primaryButton("Upload"),
            ],
          ),
        ),
      ),
    );
  }
}
