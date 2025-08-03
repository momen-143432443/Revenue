import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Infsructure/Models/UserModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getX;

class SigninContoller extends getX.GetxController {
  static SigninContoller get instance => getX.Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final Alerts alerts = Alerts();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  getX.Rx<UserModel> user = UserModel.userDataEmpty().obs;

  Future<void> signInTrigger() async {
    try {
      if (email.text.trim().isEmpty && password.text.trim().isEmpty) {
        alerts.allRequrie();
      } else if (email.text.trim().isEmpty && password.text.trim().isNotEmpty) {
        alerts.emailRequrie();
      } else if (email.text.trim().isNotEmpty && password.text.trim().isEmpty) {
        alerts.passwordRequrie();
      } else if (email.text.trim().isNotEmpty &&
          password.text.trim().isNotEmpty) {
        Loader.startLoading();

        await AuthenticationRepo.instance
            .signInWithEmail(email.text.trim(), password.text.trim())
            .then((value) {
          Loader.startLoading();
          getX.Get.offAll(() => const NaviBar(),
              transition: getX.Transition.rightToLeft);
        }).onError(
          (error, stackTrace) {
            Loader.stopLoading();
            // print(error.toString());
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      Loader.stopLoading();
      if (e.code == 'wrong-password') {
        alerts.passwordIncorrect(); // 🔔 Your custom alert
      } else if (e.code == 'user-not-found') {
        alerts.userInvaild(); // 🔔 Custom alert for unknown email
      }
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    } catch (e) {
      Loader.stopLoading(); // Just in case
      alerts.ifErrors("Something went wrong.");
    }
  }

  Future<void> googleSignIn() async {
    final auth = AuthenticationRepo.instance;
    try {
      Loader.startLoading();
      await auth.signInWithGoogle();
      Loader.startLoading();
      getX.Get.offAll(const NaviBar(), transition: getX.Transition.rightToLeft);
    } on FirebaseAuthException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    } catch (e) {
      Loader.stopLoading(); // Just in case
      alerts.ifErrors("Couldn't Sign In Using Google.");
    }
  }
}
