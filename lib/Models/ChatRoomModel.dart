import 'dart:typed_data';

class ChatRoom {
  final String roomID;
  final String userID;
  final String peerID;
  final String peerUsername;
  final String peerProfileUrl;
  final String lastMsg;
  final DateTime lastMsgTime;

  ChatRoom({
    required this.roomID,
    required this.peerID,
    required this.userID,
    required this.peerProfileUrl,
    required this.peerUsername,
    required this.lastMsg,
    required this.lastMsgTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomID'] = this.roomID;
    data['userID'] = this.userID;
    data['peerID'] = this.peerID;
    data['peerProfileUrl'] = this.peerProfileUrl;
    data['peerUsername'] = this.peerUsername;
    data['lastMsg'] = this.lastMsg;
    data['lastMsgTime'] = this.lastMsgTime;
    return data;
  }
}
