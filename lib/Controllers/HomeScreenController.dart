import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/CommentModel.dart';
import 'package:uuid/uuid.dart';

class HomeScreenController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt comments = 0.obs;
  String postId;
  TextEditingController commentController = TextEditingController();
  HomeScreenController({required this.postId});
  RxBool isUploadingComment = false.obs;
  @override
  void onInit() {
    super.onInit();
    getComments();
  }

  void getComments() async {
    print("isideeeeeeeeee");
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .get();
    comments.value = snap.docs.length;
  }

  void likeHandler(List<dynamic> postLikes, String postID) async {
    const userID = "5mOCKrOcDuf3iqBp64Ls38boZ973";
    if (postLikes.contains(userID)) {
      await FirebaseFirestore.instance.collection("posts").doc(postID).update({
        "likes": FieldValue.arrayRemove([userID])
      });
    } else {
      await FirebaseFirestore.instance.collection("posts").doc(postID).update({
        "likes": FieldValue.arrayUnion([userID])
      });
    }
  }

  void addComment(String postID, String userProfileImg, String username) async {
    isUploadingComment.value = true;
    const userID = "5mOCKrOcDuf3iqBp64Ls38boZ973";
    String commentID = Uuid().v1();
    Comment comment = Comment(
        commentID: commentID,
        PostID: postID,
        userID: userID,
        userProfileImg: userProfileImg,
        username: username,
        likes: [],
        dateTime: DateTime.now(),
        comment: commentController.text);

    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postID)
        .collection("comments")
        .doc(commentID)
        .set(comment.toJson())
        .whenComplete(() {
      isUploadingComment.value = false;
      commentController.text = "";
    });
  }
}
