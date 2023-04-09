import 'dart:typed_data';

class Message {
  final String messageID;
  final String userID;
  final String peerID;
  final String message;
  final String peerProfileUrl;
  final String roomID;
  final DateTime msgTime;

  Message({
    required this.roomID,
    required this.peerID,
    required this.userID,
    required this.peerProfileUrl,
    required this.messageID,
    required this.msgTime,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomID'] = this.roomID;
    data['userID'] = this.userID;
    data['peerID'] = this.peerID;
    data['peerProfileUrl'] = this.peerProfileUrl;
    data['messageID'] = this.messageID;
    data['message'] = this.message;
    data['msgTime'] = this.msgTime;
    return data;
  }
}
