import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Controllers/ForUserControllers/BaseUrl.dart';
import 'package:css/Front/SignPages/OTPVerificationScreen.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SendOTPToEmail extends GetxController {
  static SendOTPToEmail get instance => Get.find();
  final TextEditingController email = TextEditingController();
  Future<void> resetPasswordUsingEmailWithOTP() async {
    const sendOTPToUser = '${baseURL}sendOTPToEmail';
    final url = Uri.parse(sendOTPToUser);
    try {
      Loader.startLoading();
      await http.post(url,
          body: jsonEncode({
            'email': email.text,
          }),
          headers: {'Content-Type': 'application/json'});
      // Loader.stopLoading();
      Get.to(() => OTPVerificationScreen(email: email.text));
    } catch (e) {
      print("Forget password error contorller:$e");
      Loader.startLoading();
    }
  }
}

class VerfiyOTPToEmail extends GetxController {
  static VerfiyOTPToEmail get instance => Get.find();
  final TextEditingController otpController = TextEditingController();
  late String email;
  Future<void> verifyOTP() async {
    const verifyOTPOfEmail = '${baseURL}verfiyOTPToResetPassword';
    final url = Uri.parse(verifyOTPOfEmail);
    try {
      // Loader.startLoading();

      await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'otp': otpController.text.trim()}));
      await AuthenticationRepo.instance.resetPasswordUsingEmail(email);

      // Loader.startLoading();

      // Get.to(() => const ForgetPassPage());
    } catch (e) {
      print("Forget password error contorller:$e");
      Loader.startLoading();
    }
  }
}
