import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Views/HomeScreen/Components/postCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBgColor,
        title: Container(
            margin: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              height: 50,
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.notifications,
              color: greenColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: appBgColor,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              }
              return Expanded(
                  child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, idx) {
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("posts")
                        .doc(snapshot.data!.docs[idx]["postID"])
                        .collection("comments")
                        .get(),
                    builder: (context, s) {
                      if (s.hasData) {
                        return postCard(
                            snapshot.data!.docs[idx], s.data!.docs.length);
                      }
                      return Container();
                    },
                  );
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
