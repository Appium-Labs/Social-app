import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class PostScreenController extends GetxController {
  Rx<Uint8List> image = Uint8List(0).obs;
  RxBool isSelected = false.obs;

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      image.value = await imageFile.readAsBytes();
      isSelected.value = true;
      print(image.value);
    } else {
      print("No Image Selected!");
    }
  }
}
