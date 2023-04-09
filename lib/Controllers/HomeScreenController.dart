import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Models/CommentModel.dart';
import 'package:uuid/uuid.dart';

class HomeScreenController extends GetxController
    with GetTickerProviderStateMixin {
  TextEditingController commentController = TextEditingController();
  RxBool isUploadingComment = false.obs;
  final prefs = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void likeHandler(List<dynamic> postLikes, String postID) async {
    var userID = prefs.read("user_id").toString();
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

  void commentLikeHandler(
      List<dynamic> commentLikes, String postID, String commentID) async {
    var userID = prefs.read("user_id").toString();
    if (commentLikes.contains(userID)) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postID)
          .collection("comments")
          .doc(commentID)
          .update({
        "likes": FieldValue.arrayRemove([userID])
      });
    } else {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postID)
          .collection("comments")
          .doc(commentID)
          .update({
        "likes": FieldValue.arrayUnion([userID])
      });
    }
  }

  void addComment(String postID, String userProfileImg, String username) async {
    isUploadingComment.value = true;
    var userID = prefs.read("user_id").toString();
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
