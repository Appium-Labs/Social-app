import 'dart:typed_data';

class Post {
  final String postID;
  final String caption;
  final String userID;
  final String username;
  final String userProfileImg;
  final String postUrl;
  final dateTime;
  final likes;

  Post({
    required this.postID,
    required this.caption,
    required this.userID,
    required this.userProfileImg,
    required this.username,
    required this.postUrl,
    this.dateTime,
    this.likes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['userID'] = this.userID;
    data['userProfileImg'] = this.userProfileImg;
    data['username'] = this.username;
    data['postUrl'] = this.postUrl;
    data['likes'] = this.likes;
    data['caption'] = this.caption;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
