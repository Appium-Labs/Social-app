import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/HomeScreenController.dart';

import '../../../Constants.dart';

Widget commentCard(final snap) {
  HomeScreenController homeScreenController = Get.find();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: 3),
      trailing: Text(
        getDate(snap["dateTime"]),
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black.withOpacity(0.8),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 10),
      ),
      leading: Column(
        children: [
          Image.network(
            snap["userProfileImg"],
            height: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  homeScreenController.commentLikeHandler(
                      snap["likes"], snap["PostID"], snap["commentID"]);
                },
                child: snap["likes"].contains(snap["userID"])
                    ? const Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite,
                        size: 20,
                      ),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                snap["likes"].length.toString(),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryTextColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              )
            ],
          ),
        ],
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
        snap["comment"],
        style: const TextStyle(
            fontFamily: 'Poppins',
            color: primaryTextColor,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 12),
      ),
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
