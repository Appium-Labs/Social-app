import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/HomeScreenController.dart';

import '../CommentScreen.dart';

Widget postCard(final snap) {
  HomeScreenController homeScreenController =
      Get.put(HomeScreenController(postId: snap["postID"]));
  return Container(
    decoration: BoxDecoration(
        color: postPrimaryColor,
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
          title: Text(
            snap["username"],
            style: const TextStyle(
                fontFamily: 'Poppins',
                color: primaryTextColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 15),
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
        Text(
          snap["caption"],
          style: const TextStyle(
              fontFamily: 'Roboto',
              color: primaryTextColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 12),
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
          height: 200,
          child: Image.network(
            snap["postUrl"],
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: () {
                  homeScreenController.likeHandler(
                      snap["likes"], snap["postID"]);
                },
                child: snap["likes"].contains(snap["userID"])
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.grey[400],
                      )),
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
            Obx(
              () => Text(
                homeScreenController.comments.value.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: primaryTextColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              Get.to(CommentScreen(
                snap: snap,
              ));
            },
            child: Text(
              "View all ${homeScreenController.comments.value.toString()} comments",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: secondaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
        )
      ],
    ),
  );
}

String getDate(Timestamp timeStamp) {
  DateTime postDateTime = timeStamp.toDate();
  DateTime currentDateTime = DateTime.now();
  final dayDiff = currentDateTime.difference(postDateTime).inDays;
  final hourDiff = currentDateTime.difference(postDateTime).inHours;
  final minuteDiff = currentDateTime.difference(postDateTime).inMinutes;
  if (minuteDiff <= 60) {
    return minuteDiff.toString() + " minutes ago";
  } else if (hourDiff <= 24) {
    return hourDiff.toString() + " hours ago";
  } else if (dayDiff <= 29) {
    return dayDiff.toString() + " days ago";
  } else {
    int monthDiff = int.parse((dayDiff / 30).toString());
    if (monthDiff >= 12) {
      return monthDiff.toString() + " months ago";
    } else {
      int yearDiff = int.parse((monthDiff / 12).toString());
      return yearDiff.toString() + " years ago";
    }
  }
}
