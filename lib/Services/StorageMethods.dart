import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final prefs = GetStorage();
  Future<String> uploadImageToFirebase(
      String childname, Uint8List file, bool isPost) async {
    Reference ref =
        _firebaseStorage.ref().child(childname).child(prefs.read("user_id"));
    if (isPost == true) {
      var postID = const Uuid().v1();
      ref = ref.child(postID);
    }
    await ref.putData(file);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}
