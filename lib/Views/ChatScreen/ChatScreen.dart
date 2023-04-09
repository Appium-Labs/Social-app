import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/ChatController.dart';

import 'Components/Chat.dart';

class ChatScreen extends StatelessWidget {
  String peerName;
  String peerProfileImg;
  String peerID;
  String userID;
  String roomID;

  ChatScreen(
      {required this.peerName,
      required this.peerProfileImg,
      required this.peerID,
      required this.userID,
      required this.roomID});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.find();
    final prefs = GetStorage();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => chatController.scrollDown());
    return Scaffold(
      // bottomNavigationBar: TextField(),
      appBar: AppBar(
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: Image.network(
                peerProfileImg,
                height: 10,
                width: 50,
              ),
            ),
          ),
        ],
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
        ),
        backgroundColor: appBgColor,
        toolbarHeight: 75,
        centerTitle: true,
        title: Text(
          peerName,
          style: const TextStyle(
              fontFamily: 'Poppins',
              color: primaryTextColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          // color: Colors.red,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chats")
                .doc(roomID)
                .collection("messages")
                .orderBy("msgTime", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return ListView.builder(
                // reverse: true,
                controller: chatController.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length + 1,
                itemBuilder: (context, index) {
                  if (index >= snapshot.data!.docs.length) {
                    return const SizedBox(
                      height: 100,
                    );
                  }
                  return Container(
                    alignment: snapshot.data!.docs[index]["userID"] == userID
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(vertical: 9),
                    child: Chat(
                        snap: snapshot.data!.docs[index],
                        sentByMe:
                            snapshot.data!.docs[index]["userID"] == userID),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: chatController.messageController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: GestureDetector(
                  onTap: () {
                    chatController.currMsg =
                        chatController.messageController.text;
                    chatController.messageController.text = "";
                    chatController.sendMessage(peerID, userID, peerProfileImg);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset("assets/icons/send.svg"),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset("assets/icons/plus.svg"),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: greenColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: greenColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
                hintText: "Message"),
          ),
        ),
      ]),
    );
  }
}
