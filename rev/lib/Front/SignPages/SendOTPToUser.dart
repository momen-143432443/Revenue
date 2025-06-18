import 'package:css/Backend/Controllers/ForUserControllers/PasswordController.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SendOTPToUser extends StatefulWidget {
  const SendOTPToUser({super.key});

  @override
  State<SendOTPToUser> createState() => _SendOTPToUserState();
}

final controller = Get.put(SendOTPToEmail());

class _SendOTPToUserState extends State<SendOTPToUser> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Send OTP",
          style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              enterYourEmailForVerification(),
              const SizedBox(height: 10),
              emailTextField(),
              const SizedBox(height: 10),
              weWillSendToYouAVerficationCodeToEnsureYouAreTheAccountAdmin(),
              const SizedBox(height: 10),
              sendOTPToUser(size)
            ],
          ),
        ),
      )),
    );
  }

  SizedBox sendOTPToUser(Size size) {
    return SizedBox(
      width: size.width / 2,
      child: ElevatedButton(
          onPressed: () async =>
              await controller.resetPasswordUsingEmailWithOTP(),
          child: Text(
            "Send",
            style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w500),
          )),
    );
  }

  Padding weWillSendToYouAVerficationCodeToEnsureYouAreTheAccountAdmin() {
    return Padding(
      padding: const EdgeInsets.only(left: 23),
      child: Text(
        "We Will Send To You A Verfication Code To Ensure You are The Account Admin",
        style: GoogleFonts.aleo(
            fontSize: 12, color: black, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller.email,
        cursorRadius: const Radius.circular(3),
        autocorrect: true,
        enableInteractiveSelection: true,
        cursorColor: Colors.white,
        style: const TextStyle(color: black),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.email_outlined, color: white),
          labelText: 'Email',
          labelStyle: const TextStyle(color: black),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        ),
      ),
    );
  }

  Padding enterYourEmailForVerification() {
    return Padding(
      padding: const EdgeInsets.only(right: 170),
      child: Text(
        "Enter Your Email For Verification",
        style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w500),
      ),
    );
  }
}
