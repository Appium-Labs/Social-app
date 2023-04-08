import 'package:cloud_firestore/cloud_firestore.dart';

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
