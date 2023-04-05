import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_app/Views/NewUserScreen/NewUserScreen.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeBackScreen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var verificationId = "".obs;
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
      if (credential.additionalUserInfo!.isNewUser) {
        Get.to(NewUserScreen());
      } else {
        Get.to(WelcomeBackScreen());
      }
    } catch (err) {
      Get.snackbar("Error", "Wrong top or expired, try again");
    }
    isLoading.value = false;
  }
}
