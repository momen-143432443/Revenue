import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Front/SignPages/Signin.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;

class SignOutCopntroller extends getx.GetxController {
  static SignOutCopntroller get instance => getx.Get.find();
  final out = getx.Get.put(AuthenticationRepo());
  final Alerts alerts = Alerts();

  Future<void> signOutTrigger() async {
    try {
      Loader.startLoading();
      await out.signOut();
      Loader.stopLoading();
      getx.Get.offAll(() => const SignIn(),
          transition: getx.Transition.rightToLeft);
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } catch (e) {
      throw 'Somthing went wrong, please try later';
    }
  }
}
