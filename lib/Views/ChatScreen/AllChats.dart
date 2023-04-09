import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/ChatController.dart';
import 'package:social_app/Views/ChatScreen/ChatScreen.dart';
import 'package:social_app/Views/ChatScreen/Components/Chat.dart';
import 'package:social_app/Views/ChatScreen/Components/SearchBar.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    final prefs = GetStorage();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        centerTitle: true,
        title: const Text(
          "Chats",
          style: TextStyle(
              fontFamily: 'Poppins',
              color: primaryTextColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBar(),
          const SizedBox(
            height: 14,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "All Messages",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryTextColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chats")
                .where("userID", isEqualTo: prefs.read("user_id").toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(ChatScreen(
                            peerName: snap["peerUsername"],
                            peerProfileImg: snap["peerProfileUrl"],
                            peerID: snap["peerID"],
                            userID: snap["userID"],
                            roomID: snap["roomID"]));
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            snap["peerProfileUrl"],
                            height: 50,
                            width: 50,
                          ),
                        ),
                        title: Text(
                          snap["peerUsername"],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: primaryTextColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          snap["lastMsg"],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: greenColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Text(
                          getDate(snap["lastMsgTime"]),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            // color: primaryTextColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
