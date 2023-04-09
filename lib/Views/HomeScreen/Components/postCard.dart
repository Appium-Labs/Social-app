import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/HomeScreenController.dart';
import 'package:social_app/Views/HomeScreen/Components/DateConverter.dart';

import '../CommentScreen.dart';

Widget postCard(final snap, final comments) {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  print(snap["userID"]);
  return Container(
    decoration: BoxDecoration(
        color: postPrimaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              snap["userProfileImg"],
              fit: BoxFit.fill,
            ),
          ),
          title: GestureDetector(
            onTap: () {},
            child: Text(
              snap["username"],
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          subtitle: Text(
            getDate(snap["dateTime"]),
            style: const TextStyle(
                fontFamily: 'Poppins',
                color: primaryTextColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 0.5, color: Colors.black)),
          width: double.infinity,
          height: 250,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              snap["postUrl"],
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              snap["username"],
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              snap["caption"],
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 9,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            snap["likes"].contains(snap["userID"])
                ? GestureDetector(
                    onTap: () {
                      homeScreenController.likeHandler(
                          snap["likes"], snap["postID"]);
                    },
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      tween:
                          ColorTween(end: Colors.red, begin: Colors.grey[400]),
                      builder: (context, value, child) {
                        return Icon(Icons.favorite, color: value);
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      homeScreenController.likeHandler(
                          snap["likes"], snap["postID"]);
                    },
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 500),
                      tween:
                          ColorTween(begin: Colors.red, end: Colors.grey[400]),
                      builder: (context, value, child) {
                        return Icon(Icons.favorite, color: value);
                      },
                    ),
                  ),
            const SizedBox(
              width: 5,
            ),
            Text(
              snap["likes"].length.toString(),
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(CommentScreen(
                  snap: snap,
                ));
              },
              child: Icon(
                Icons.comment,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              comments.toString(),
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            Get.to(CommentScreen(
              snap: snap,
            ));
          },
          child: Text(
            "View all ${comments.toString()} comments",
            style: TextStyle(
                fontFamily: 'Roboto',
                color: secondaryTextColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
