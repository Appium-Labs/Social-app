import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Constants.dart';
import 'package:social_app/Controllers/ChatController.dart';
import 'package:social_app/Controllers/PrfileController.dart';
import 'package:social_app/Controllers/UserController.dart';
import 'package:social_app/Views/ChatScreen/chatScreen.dart';

import '../ProfileScreen/EditProfileScreen.dart';

class UserScreen extends StatefulWidget {
  final String userId;
  const UserScreen({super.key, required this.userId});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    final prefs = GetStorage();
    UserController controller = Get.put(UserController());
    controller.getUser(widget.userId);
    controller.getPosts(widget.userId);
    bool isAlreadyFollowing = false;
    controller
        .checkIfUserIsFollower(prefs.read("user_id"), widget.userId)
        .then((value) => isAlreadyFollowing = value);

    bool isThisMe = widget.userId == prefs.read("user_id").toString();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xff1C6758)),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(controller
                                          .user.value.profilePhoto ==
                                      ""
                                  ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                                  : controller.user.value.profilePhoto
                                      .toString()),
                              radius: 35,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.user.value.fullname.toString(),
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    isThisMe
                                        ? Container()
                                        : GestureDetector(
                                            onTap: () {
                                              chatController.generateRoomId(
                                                  widget.userId,
                                                  prefs
                                                      .read("user_id")
                                                      .toString());
                                              chatController.createRoom(
                                                  prefs
                                                      .read("user_id")
                                                      .toString(),
                                                  controller.user.value,
                                                  widget.userId);
                                              Get.to(ChatScreen(
                                                peerName: controller
                                                    .user.value.username,
                                                peerProfileImg: controller
                                                    .user.value.profilePhoto,
                                                peerID: widget.userId,
                                                roomID:
                                                    chatController.roomID.value,
                                                userID: prefs
                                                    .read("user_id")
                                                    .toString(),
                                              ));
                                            },
                                            child: const Icon(
                                              Icons.message_rounded,
                                              color: greenColor,
                                            ),
                                          )
                                  ],
                                ),
                                Text(
                                  controller.user.value.username.toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.user.value.bio,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    isThisMe
                        ? SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () => Get.to(EditProfileScreen()),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1C6758),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                if (isAlreadyFollowing) {
                                  controller
                                      .unfollowUser(
                                          prefs.read("user_id"), widget.userId)
                                      .then((value) => setState(() {
                                            isAlreadyFollowing =
                                                !isAlreadyFollowing;
                                          }));
                                } else {
                                  controller
                                      .updateFollowersAndFollowing(
                                          prefs.read("user_id").toString(),
                                          widget.userId)
                                      .then((value) => setState(() {
                                            isAlreadyFollowing =
                                                !isAlreadyFollowing;
                                          }));
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff1C6758),
                                        width: isAlreadyFollowing ? 1 : 0),
                                    color: isAlreadyFollowing == true
                                        ? Colors.white
                                        : const Color(0xff1C6758),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  isAlreadyFollowing == true
                                      ? "Unfollow"
                                      : "Follow",
                                  style: TextStyle(
                                      color: isAlreadyFollowing == true
                                          ? Color(0xff1C6758)
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.posts.length.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Posts")
                              ],
                            ),
                            Container(
                              width: 1.6,
                              height: 40,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  (controller.user.value.following.length)
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Following")
                              ],
                            ),
                            Container(
                              width: 1.6,
                              height: 40,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  (controller.user.value.followers.length)
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Followers")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              controller.posts.value[index].postUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        childCount: controller.posts.length,
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
