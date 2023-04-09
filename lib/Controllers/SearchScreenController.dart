import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchScreenController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  RxBool showUsers = false.obs;
  final userList = [].obs;

  void getUsers() async {
    // print("changed");
    if (usernameController.text == "") {
      userList.value = [];
      return;
    }
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isGreaterThanOrEqualTo: usernameController.text)
        .get();
    final list = snap.docs;
    userList.value = list;
    for (var i = 0; i < userList.length; i++) {
      print(userList[i]["username"]);
    }
  }
}
