import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/HomeScreenController.dart';

import '../../Constants.dart';
import 'Components/commentCard.dart';
import 'Components/postCard.dart';

class CommentScreen extends StatelessWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.find();

    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Comments",
            style: TextStyle(color: primaryTextColor),
          ),
          backgroundColor: appBgColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height - 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .doc(snap["postID"])
                        .collection("comments")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: greenColor,
                          ),
                        );
                      }
                      print(snapshot.data!.docs);
                      if (snapshot.data == null) {
                        return Text("not data");
                      }
                      // return Text("data");
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return commentCard(snapshot.data!.docs[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: greenColor,
            height: 50,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Image.network(
                      homeScreenController.profileImg.value,
                      // height: 10,
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        controller: homeScreenController.commentController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText:
                              "Comment as ${homeScreenController.username.value}",
                          hintStyle: const TextStyle(
                              color: Colors.white60,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        homeScreenController.addComment(
                          snap["postID"],
                          homeScreenController.profileImg.value,
                          homeScreenController.username.value,
                        );
                      },
                      child:
                          homeScreenController.isUploadingComment.value == true
                              ? const CircularProgressIndicator(
                                  color: greenColor,
                                )
                              : const Text(
                                  "Post",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
