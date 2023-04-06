import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Services/StorageMethods.dart';
import 'package:uuid/uuid.dart';

class PostScreenController extends GetxController {
  Rx<Uint8List> image = Uint8List(0).obs;
  RxBool isSelected = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isImageUploaded = false.obs;
  TextEditingController captionController = TextEditingController();

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      image.value = await imageFile.readAsBytes();
      isSelected.value = true;
      print(image.value);
    } else {
      print("No Image Selected!");
    }
  }

  void uploadPost(String caption) async {
    final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;
    String userID = "5mOCKrOcDuf3iqBp64Ls38boZ973";
    var postID = const Uuid().v1();
    isImageUploading.value = true;
    String postUrl = await StorageMethods()
        .uploadImageToFirebase("posts", image.value, true);
    print(postUrl);
    print(postID);
    Post newPost = Post(
        postID: postID,
        caption: caption,
        userID: userID,
        likes: [],
        userProfileImg:
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
        username: "Ankur",
        postUrl: postUrl,
        dateTime: DateTime.now());
    await _firebaseStorage
        .collection("posts")
        .doc(postID)
        .set(newPost.toJson());
    isImageUploading.value = false;
    isImageUploaded.value = true;
    isSelected.value = false;
    image.value = Uint8List(0);
    captionController.text = "";
    print("hellllllllllllo");
    Get.snackbar("Uploaded", "Image has been uploaded");
    print("success");
  }
}
