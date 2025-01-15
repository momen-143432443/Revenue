import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Front/SignPages/Signin.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignOutCopntroller extends GetxController {
  static SignOutCopntroller get instance => Get.find();
  final out = Get.put(AuthenticationRepo());

  Future<void> signOutTrigger() async {
    try {
      Loader.startLoading();
      await out.signOut();
      Loader.stopLaoding();
      Get.offAll(() => const SignIn());
    } on FirebaseAuthException catch (e) {
      ifErrors(e.message.toString());
      Loader.stopLaoding();
    } on PlatformException catch (e) {
      ifErrors(e.message.toString());
      Loader.stopLaoding();
    } catch (e) {
      throw 'Somthing went wrong, please try later';
    }
  }
}
