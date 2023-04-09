import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Services/StorageMethods.dart';
import 'package:uuid/uuid.dart';

import '../Models/UserModel.dart';

class PostScreenController extends GetxController {
  var user = UserModel(
      fullname: "",
      username: "",
      email: "",
      password: "",
      dateOfBirth: "",
      gender: "",
      bio: "",
      profilePhoto: "",
      followers: [],
      following: []).obs;
  Rx<Uint8List> image = Uint8List(0).obs;
  RxBool isSelected = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isImageUploaded = false.obs;
  TextEditingController captionController = TextEditingController();
  final prefs = GetStorage();

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
    String userID = prefs.read("user_id");

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
        userProfileImg: user.value.profilePhoto == ""
            ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            : user.value.profilePhoto,
        username: user.value.fullname,
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

  void getCurrentUser() async {
    // isLoading.value = true;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot =
        await usersCollection.doc(prefs.read("user_id").toString()).get();

    if (documentSnapshot.exists) {
      // Document exists
      var data = documentSnapshot;

      UserModel currUser = UserModel(
          fullname: data.get("fullname"),
          username: data.get("username"),
          email: data.get("email"),
          password: "",
          dateOfBirth: data.get("dateOfBirth"),
          gender: data.get("gender"),
          bio: data.get("bio"),
          profilePhoto: data.get("profilePhoto"),
          followers: data.get("followers"),
          following: data.get("following"));
      user.value = currUser;
      // Access the data using data["fieldName"]
    } else {
      // Document does not exist
    }

    // isLoading.value = false;
  }
}
