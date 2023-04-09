import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/SearchScreenController.dart';
import 'package:social_app/Views/UserScreen/UserScreen.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    SearchScreenController searchScreenController = Get.find();
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchScreenController.userList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(UserScreen(
                    userId: searchScreenController.userList[index].id));
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    searchScreenController.userList[index]["profilePhoto"],
                    height: 50,
                    width: 50,
                  ),
                ),
                title: Text(searchScreenController.userList[index]["username"]),
                subtitle:
                    Text(searchScreenController.userList[index]["fullname"]),
              ),
            );
          },
        ),
      ),
    );
  }
}
