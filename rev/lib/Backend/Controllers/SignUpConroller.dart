import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/services/Api.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupConroller extends GetxController {
  static SignupConroller get instance => Get.find();

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

      final user = {
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
      };

      await Api.signUpToApp(user);
      Loader.stopLaoding();
      Get.offAll(() => const NaviBar());
    } on FirebaseAuthException catch (e) {
      ifErrors(e.message.toString());
      Loader.stopLaoding();
    }
  }
}
