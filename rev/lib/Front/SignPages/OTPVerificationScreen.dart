import 'package:css/Backend/Controllers/ForUserControllers/PasswordController.dart';
import 'package:css/Front/SignPages/Signin.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.email});
  final String email;
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

final controller = Get.put(VerfiyOTPToEmail());

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  @override
  void initState() {
    super.initState();
    controller.email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: white,
        appBar: interOTPAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 75),
                  child: Column(
                    children: [
                      oTPTextField(),
                      const SizedBox(height: 10),
                      ifTheOTPDidntWorkRequestAnotherOneAfter30Sec(),
                      const SizedBox(height: 60),
                      movingToModifyingPassword(size)
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  AppBar interOTPAppBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        "Inter OTP",
        style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w500),
      ),
    );
  }

  SizedBox movingToModifyingPassword(Size size) {
    return SizedBox(
      width: size.width / 2,
      child: ElevatedButton(
          onPressed: () {
            controller.verifyOTP();
            setState(() {
              dialogMovingToSignInPage();
            });
          },
          child: Text(
            "Send",
            style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w500),
          )),
    );
  }

  Future<Object?> dialogMovingToSignInPage() {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.ease);
          return ScaleTransition(
            scale: curved,
            child: FadeTransition(
              opacity: curved,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation1, animation2) => AlertDialog(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              title: Text(
                "OTP Sent Successfully.",
                style:
                    GoogleFonts.aleo(color: black, fontWeight: FontWeight.w600),
              ),
              content: SingleChildScrollView(
                child: Text(
                  "You'll Receive An Email To Reset Your Password",
                  style: GoogleFonts.aleo(
                      color: black, fontWeight: FontWeight.w400),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Get.offAll(() => const SignIn()),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: skyer),
                    )),
              ],
            ));
  }

  Text ifTheOTPDidntWorkRequestAnotherOneAfter30Sec() {
    return Text(
      "If The OTP Didn't Work, Request Another One After 30 Sec",
      style: GoogleFonts.aleo(
          fontSize: 12, color: black, fontWeight: FontWeight.w500),
    );
  }

  Padding oTPTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller.otpController,
        cursorRadius: const Radius.circular(3),
        autocorrect: true,
        enableInteractiveSelection: true,
        cursorColor: Colors.white,
        style: const TextStyle(color: black),
        decoration: InputDecoration(
          suffixIcon: const Icon(FontAwesomeIcons.codeCommit, color: white),
          labelText: 'Your OTP',
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
}
