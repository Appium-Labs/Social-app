import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Constants.dart';

class Chat extends StatelessWidget {
  final snap;
  bool sentByMe;
  Chat({super.key, required this.snap, required this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.8,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: sentByMe ? Colors.grey[200] : msgColor,
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomRight: sentByMe == true
                ? const Radius.circular(0)
                : const Radius.circular(20),
            bottomLeft: sentByMe == true
                ? const Radius.circular(20)
                : const Radius.circular(0)),
      ),
      child: Column(
        children: [
          Text(
            snap["message"],
            style: TextStyle(
                fontFamily: 'Poppins',
                color: sentByMe ? Colors.black : Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  getDate(snap["msgTime"]),
                  style: TextStyle(
                      color: sentByMe ? Colors.black : Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String getDate(Timestamp timestamp) {
  DateTime time = timestamp.toDate();
  return time.hour.toString() + ":" + time.minute.toString();
}
