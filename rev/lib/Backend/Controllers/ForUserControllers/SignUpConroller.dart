import 'dart:convert';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:http/http.dart' as http;
import 'package:css/Backend/Controllers/ForUserControllers/BaseUrl.dart';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
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
          context: navigator!.context,
          onTap: () async {},
        );
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
          };
          print(user);
          await http
              .post(Uri.parse(resgistration),
                  headers: {"Content-type": "application/json"},
                  body: jsonEncode(user))
              .then((value) {
            Loader.startLoading();
            Get.offAll(() => const NaviBar());
          }).onError(
            (error, stackTrace) {
              Loader.stopLoading();
              alerts.ifErrors(error.toString());
              // alerts.exceptions('Somthing went wrong');
              print(error.toString());
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      }
    }
  }
}
