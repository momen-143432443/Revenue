import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:css/Backend/Repositories/UserRepository/UserRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupConroller extends GetxController {
  static SignupConroller get instance => Get.find();

  final hiId = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  Future<void> signUpTrigger() async {
    try {
      Loader.startLoading();
      await AuthenticationRepo.instance
          .signUpWithEmail(email.text.trim(), password.text.trim());

      final user = UserModel(
          id: AuthenticationRepo.instance.authUser?.uid,
          hrID: hiId.text.trim(),
          email: email.text.trim(),
          password: password.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim());

      final save = Get.put(UserRepo());
      await save.saveUserRecords(user);
      Loader.stopLaoding();
      Get.offAll(() => const NaviBar());
    } on FirebaseAuthException catch (e) {
      ifErrors(e.message.toString());
      Loader.stopLaoding();
    }
  }
}
