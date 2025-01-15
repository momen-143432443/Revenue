import 'package:css/Front/SignPages/Signin.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.put(AuthenticationRepo());

  final auth = FirebaseAuth.instance;

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
      ifErrors(e.message.toString());
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ifErrors(e.message.toString());
    }
  }

  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } on FirebaseAuthException catch (e) {
      ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      ifErrors(e.message.toString());
    } catch (e) {
      throw 'Somthing went wrong, please try later';
    }
  }
}
