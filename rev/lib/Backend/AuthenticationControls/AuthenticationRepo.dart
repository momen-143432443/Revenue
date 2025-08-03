import 'package:css/Front/SignPages/Signin.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.put(AuthenticationRepo());

  final auth = FirebaseAuth.instance;
  final Alerts alerts = Alerts();
  final googleSign = GoogleSignIn();

  User? get authUser => auth.currentUser;

  @override
  void onReady() {
    print(auth.currentUser?.email);
    pageWrapper();
  }

  void pageWrapper() async {
    if (authUser != null /* If authenticaton signed */) {
      Get.offAll(() => const NaviBar());
    } else if (authUser == null) {
      Get.offAll(() => const SignIn());
    }
    print(auth.currentUser?.email);
  }

  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.code} - ${e.message}');
      if (e.code == "email-already-in-use") {
        alerts.emailAlreadyUsed();
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.code} - ${e.message}');
      if (e.code == "wrong-password") {
        alerts.passwordIncorrect();
      } else if (e.code == "email-already-in-use") {
        alerts.emailAlreadyUsed();
      } else if (e.code == "invalid-email") {
        alerts.invalidEmail();
      }
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    } catch (e) {
      throw 'Somthing went wrong, please try later';
    }
  }

  Future<void> resetPasswordUsingEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    } catch (E) {
      print("Forget password error: $E");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
