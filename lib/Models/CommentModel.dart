import 'dart:typed_data';

class Comment {
  final String commentID;
  final String PostID;
  final String userID;
  final String username;
  final String userProfileImg;
  final String comment;
  final dateTime;
  final likes;

  Comment({
    required this.commentID,
    required this.PostID,
    required this.userID,
    required this.userProfileImg,
    required this.username,
    required this.comment,
    this.dateTime,
    this.likes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentID'] = this.commentID;
    data['userID'] = this.userID;
    data['userProfileImg'] = this.userProfileImg;
    data['username'] = this.username;
    data['PostID'] = this.PostID;
    data['likes'] = this.likes;
    data['comment'] = this.comment;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
