import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/Views/NewUserScreen/NewUserScreen.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeBackScreen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var verificationId = "".obs;
  var fullName = "".obs;
  var email = "".obs;
  var bio = "".obs;
  var dataOfBirth = "".obs;
  var gender = "".obs;
  var username = "".obs;
  var password = "".obs;
  var user_id = "".obs;
  var prefs = GetStorage();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    print("first");
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print("singup complete");
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        if (e.code == 'phone-already-in-use') {
          // The phone number is already registered
          Get.snackbar("Error", "Phone number already in use please sign-in");
          return;
        }
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    print("secnod");
  }

  void verifyOTP(String otp) async {
    // Get.to(NewUserScreen());
    isLoading.value = true;
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      // await Future.delayed(Duration(seconds: 5));
      user_id.value = credential.user?.uid ?? "";
      String temp = user_id.value.toString();
      await prefs.write('user_id', temp);
      print(prefs.read('user_id') + "------");
      if (credential.additionalUserInfo!.isNewUser) {
        Get.offAll(NewUserScreen());
      } else {
        Get.offAll(WelcomeBackScreen());
      }
    } catch (err) {
      Get.snackbar("Error", "Wrong top or expired, try again");
    }
    isLoading.value = false;
  }

  Future<void> addUserToFirestore({
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String dateOfBirth,
    required String gender,
    required String bio,
    required String profilePhoto,
  }) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      var id = prefs.read("user_id");
      // Add a new user to the collection
      await users.doc(id).set({
        'fullname': fullname,
        'username': username,
        'email': email,
        'password': password,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'bio': bio,
        'profilePhoto': profilePhoto,
      });

      print('User added to Firestore successfully');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }
}
