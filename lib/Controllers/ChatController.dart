import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/ChatRoomModel.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  RxString roomID = "".obs;
  TextEditingController messageController = TextEditingController();
  String currMsg = "";
  ScrollController scrollController = ScrollController();
  RxBool needsScroll = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void sendMessage(String peerID, String userID, String peerProfileUrl) async {
    if (currMsg.isEmpty) {
      return;
    }
    DateTime now = DateTime.now();
    String messageID = Uuid().v1();
    Message message = Message(
        roomID: roomID.value,
        peerID: peerID,
        userID: userID,
        peerProfileUrl: peerProfileUrl,
        messageID: messageID,
        msgTime: now,
        message: currMsg);

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomID.value)
        .collection("messages")
        .doc(messageID)
        .set(message.toJson())
        .whenComplete(() {
      messageController.text = "";
    });
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomID.value)
        .update({
      "lastMsg": currMsg,
      "lastMsgTime": DateTime.now()
    }).whenComplete(() {
      currMsg = "";
    });
  }

  void createRoom(String userID, UserModel peer, String peerID) async {
    ChatRoom chatRoom = ChatRoom(
        roomID: roomID.value,
        peerID: peerID,
        userID: userID,
        peerProfileUrl: peer.profilePhoto,
        peerUsername: peer.username,
        lastMsg: "",
        lastMsgTime: DateTime.now());

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomID.value)
        .set(chatRoom.toJson());
    print("room create succesfully");
  }

  void generateRoomId(String peerID, String userID) {
    roomID.value = userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
    print("1111111111111111111");
    print(roomID.value);
  }
}
