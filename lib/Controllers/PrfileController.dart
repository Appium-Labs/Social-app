import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Models/UserModel.dart';

class ProfileController extends GetxController {
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
