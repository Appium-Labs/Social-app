import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Models/PostModel.dart';
import '../Models/UserModel.dart';

class UserController extends GetxController {
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

  void getUser(String userId) async {
    isLoading.value = true;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot = await usersCollection.doc(userId).get();

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

  void getPosts(String userId) async {
    isLoading.value = true;
    final CollectionReference postsCollection =
        FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot =
        await postsCollection.where('userID', isEqualTo: userId).get();

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
}
