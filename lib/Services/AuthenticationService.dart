import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_app/Views/WelcomeScreen/WelcomeBackScreen.dart';

class AuthController extends GetxController {
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
    try {
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp))
          .then((value) => print(value));
      Get.to(WelcomeBackScreen());
    } catch (err) {
      Get.snackbar("Error", "Wrong top or expired, try again");
    }
  }
}
