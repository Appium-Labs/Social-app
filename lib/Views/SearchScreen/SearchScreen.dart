import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/SearchScreenController.dart';
import 'package:social_app/Views/SearchScreen/Components/PostView.dart';
import 'package:social_app/Views/SearchScreen/Components/SearchBar.dart';
import 'package:social_app/Views/SearchScreen/Components/Userview.dart';
import '../../Constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchScreenController searchScreenController =
        Get.put(SearchScreenController());
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(color: primaryTextColor),
          ),
          backgroundColor: appBgColor,
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
          )),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: appBgColor,
          child: Expanded(
            child: Column(children: [
              const SearchBar(),
              Obx(
                () => Container(
                  child: searchScreenController.showUsers.value == false
                      ? const PostView()
                      : const UserView(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
