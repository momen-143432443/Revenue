import 'dart:convert';
import 'dart:io';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Front/SignPages/GreetingPage.dart';
import 'package:css/Front/SignPages/UploadPictureProfile.dart';
import 'package:http/http.dart' as http;
import 'package:css/Backend/BaseUrl.dart';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;

class SignupConroller extends getX.GetxController {
  static SignupConroller get instance => getX.Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final Alerts alerts = Alerts();

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  Future<void> signUpTrigger() async {
    const resgistration = "${baseURL}create";
    if (email.text.trim().isEmpty &&
        password.text.trim().isEmpty &&
        firstName.text.trim().isEmpty &&
        lastName.text.trim().isEmpty) {
      return alerts.allRequrie();
    } else if (email.text.trim().isEmpty &&
        password.text.trim().isNotEmpty &&
        firstName.text.trim().isNotEmpty &&
        lastName.text.trim().isNotEmpty) {
      return alerts.emailRequrie();
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isEmpty &&
        firstName.text.trim().isNotEmpty &&
        lastName.text.trim().isNotEmpty) {
      return alerts.passwordRequrie();
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        firstName.text.trim().isEmpty &&
        lastName.text.trim().isNotEmpty) {
      return alerts.firstNameRequrie();
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        firstName.text.trim().isNotEmpty &&
        lastName.text.trim().isEmpty) {
      return alerts.lastNameRequrie();
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        firstName.text.trim().isNotEmpty &&
        lastName.text.trim().isNotEmpty) {
      try {
        SafeTap.execute(
          // ignore: use_build_context_synchronously
          context: getX.navigator!.context,
          onTap: () async {
            Loader.startLoading();

            UserCredential? checked = await AuthenticationRepo.instance
                .signUpWithEmail(email.text.trim(), password.text.trim());

            if (checked != null) {
              final firebaseUid = checked.user?.uid;
              final user = {
                "_id": firebaseUid,
                "email": email.text.trim(),
                "password": password.text.trim(),
                "firstName": firstName.text.trim(),
                "lastName": lastName.text.trim(),
                "userPic": ""
              };
              print(user);
              await http
                  .post(Uri.parse(resgistration),
                      headers: {"Content-type": "application/json"},
                      body: jsonEncode(user))
                  .then((value) {
                Loader.startLoading();
                getX.Get.offAll(
                    () => UploadPictureProfile(
                        uid: AuthenticationRepo.instance.authUser!.uid),
                    transition: getX.Transition.rightToLeft);
              }).onError(
                (error, stackTrace) {
                  Loader.stopLoading();
                  alerts.ifErrors(error.toString());
                  // alerts.exceptions('Somthing went wrong');
                  print(error.toString());
                },
              );
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      }
    }
  }

  Future<void> uploadPic(String uid, File? imageFile) async {
    if (imageFile != null) {
      final byte = await imageFile.readAsBytes();
      final base64Image = base64Encode(byte);
      final user = AuthenticationRepo.instance.authUser?.uid;
      try {
        final forUploadPic = "${baseURL}uploadPictureToUser/$user";
        final uploadPicUser = {"base64Image": base64Image};
        print("Image Upload $base64Image");
        print(user);
        await http
            .put(Uri.parse(forUploadPic),
                headers: {"Content-type": "application/json"},
                body: jsonEncode(uploadPicUser))
            .then((value) {
          Loader.startLoading();

          getX.Get.offAll(() => const GreetingPage(),
              transition: getX.Transition.rightToLeft);
        }).onError(
          (error, stackTrace) {
            Loader.stopLoading();
            alerts.ifErrors(error.toString());
            // alerts.exceptions('Somthing went wrong');
            print(error.toString());
          },
        );
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      } catch (e) {
        print("Any Issue??? $e");
      }
    } else if (imageFile == null) {
      Loader.startLoading();

      getX.Get.offAll(() => const GreetingPage(),
          transition: getX.Transition.rightToLeft);
    }
  }
}
