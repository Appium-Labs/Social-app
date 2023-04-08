import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Models/UserModel.dart';

import '../Services/StorageMethods.dart';

class ProfileController extends GetxController {
  Rx<Uint8List> image = Uint8List(0).obs;
  RxBool isSelected = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isImageUploaded = false.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var verificationId = "".obs;
  var phoneNumber = "".obs;
  var otpControllers = List.generate(6, (index) => TextEditingController());
  var fullName = "".obs;
  var email = "".obs;
  var bio = "".obs;
  var dataOfBirth = "".obs;
  var gender = "".obs;
  var username = "".obs;
  final prefs = GetStorage();
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

  var posts = <Post>[].obs;

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
    getPosts();
  }

  void getCurrentUser() async {
    isLoading.value = true;
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

    isLoading.value = false;
  }

  void getPosts() async {
    isLoading.value = true;
    final CollectionReference postsCollection =
        FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot = await postsCollection
        .where('userID', isEqualTo: prefs.read("user_id").toString())
        .get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    print(documents.length);
    posts.value = [];
    documents.forEach((document) {
      posts.add(Post(
          postID: document.get("postID"),
          caption: document.get("caption"),
          userID: document.get("userID"),
          userProfileImg: document.get("userProfileImg"),
          username: document.get("username"),
          postUrl: document.get("postUrl")));
    });
    isLoading.value = false;
  }

  Future<void> addUserToFirestore({
    required String fullname,
    required String username,
    required String dateOfBirth,
    required String gender,
    required String bio,
    required String profilePhoto,
  }) async {
    isLoading.value = true;
    try {
      // Get a reference to the Firestore collection
      String profilePhoto = await StorageMethods()
          .uploadImageToFirebase("posts", image.value, true);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      var id = prefs.read("user_id");
      // Add a new user to the collection
      await users.doc(id).update({
        'fullname': fullname,
        'username': username,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'bio': bio,
        'profilePhoto': profilePhoto,
      });

      print('User added to Firestore successfully');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
    getCurrentUser();
    isLoading.value = false;
  }

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
}
