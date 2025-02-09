import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupConroller extends GetxController {
  static SignupConroller get instance => Get.find();
  final baseUrl = "http://192.168.1.3:3000/";
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final Alerts alerts = Alerts();

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  Future<void> signUpTrigger() async {
    final resgistration = baseUrl + "create";
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
        lastName.text.trim().isNotEmpty &&
        firstName.text.length < 6) {
      return alerts.nameLenRequrie();
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        firstName.text.trim().isNotEmpty &&
        lastName.text.trim().isNotEmpty) {
      try {
        Loader.startLoading();

        final user = {
          "email": email.text.trim(),
          "password": password.text.trim(),
          "firstName": firstName.text.trim(),
          "lastName": lastName.text.trim(),
        };
        await http
            .post(Uri.parse(resgistration),
                headers: {"Content-type": "application/json"},
                body: jsonEncode(user))
            .then((value) {
          Loader.startLoading();
          Get.offAll(() => const NaviBar());
        }).onError(
          (error, stackTrace) {
            Loader.stopLaoding();
            alerts.ifErrors(error.toString());
            // alerts.exceptions('Somthing went wrong');
            print(error.toString());
          },
        );

        await AuthenticationRepo.instance
            .signUpWithEmail(email.text.trim(), password.text.trim());

        // var jsonResponse = jsonDecode(res);
        // print(jsonResponse['status']);
        // Loader.stopLaoding();
        // if (jsonResponse['status']) {
        //   Get.offAll(() => const NaviBar());
        // } else {
        //   Loader.stopLaoding();
        //   alerts.exceptions('Somthing went wrong');
        // }
      } on FirebaseAuthException catch (e) {
        alerts.ifErrors(e.message.toString());
        Loader.stopLaoding();
      }
    }
  }
}
