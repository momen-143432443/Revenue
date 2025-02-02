import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninContoller extends GetxController {
  static SigninContoller get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final Alerts alerts = Alerts();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  Future<void> signInTrigger() async {
    try {
      Loader.startLoading();
      await AuthenticationRepo.instance
          .signInWithEmail(email.text.trim(), password.text.trim());

      Loader.stopLaoding();

      Get.offAll(() => const NaviBar());
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLaoding();
    }
  }
}
