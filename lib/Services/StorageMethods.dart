import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebase(
      String childname, Uint8List file, bool isPost) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(childname)
        .child("5mOCKrOcDuf3iqBp64Ls38boZ973");
    if (isPost == true) {
      var postID = const Uuid().v1();
      ref = ref.child(postID);
    }
    await ref.putData(file);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}
