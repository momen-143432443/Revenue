import 'dart:math';

import 'package:css/Backend/Controllers/ForUserControllers/SignInContoller.dart';
import 'package:css/Front/SignPages/SignUp.dart';
import 'package:css/Tools/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

final controller = Get.put(SigninContoller());

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passVisible = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              sizeBox(50),
              revenueIcon(width, height),
              sizeBox(100),
              email(),
              const SizedBox(height: 15),
              password(),
              sizeBox(10),
              forgetPassword(),
              sizeBox(45),
              saveAndContinue(width),
              const Divider(),
              tryToQuickSign(),
              sizeBox(15),
              GoogleSign(width: width),
              const SizedBox(height: 5),
              FacebookSign(width: width),
              sizeBox(100),
              sizeBox(height / 22),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                        onTap: () => Get.to(() => const Signup()),
                        child: Text(
                          "Press here to sign up",
                          style: GoogleFonts.aleo(
                              color: greenColor, fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Text tryToQuickSign() {
    return Text(
      "Try to quick sign",
      style: GoogleFonts.aleo(fontWeight: FontWeight.w600),
    );
  }

  SizedBox saveAndContinue(double width) {
    return SizedBox(
        width: width / 1.2,
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(grey)),
            onPressed: () async => await controller.signInTrigger(),
            child: Text(
              'Continue',
              style: GoogleFonts.aleo(color: black),
            )));
  }

  GestureDetector forgetPassword() {
    return GestureDetector(
        onTap: () => print('push to forget password'),
        child: Padding(
          padding: const EdgeInsets.only(left: 235),
          child: Text('Forget password ?', style: GoogleFonts.aleo()),
        ));
  }

  SizedBox revenueIcon(double width, double height) {
    return SizedBox(
      width: width / 1.2,
      height: height / 5,
      child: Center(
        child: Text(
          'R',
          style: GoogleFonts.italianno(
              fontSize: 115, color: lime, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Padding email() {
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
          suffixIcon: const Icon(Icons.email_outlined, color: black),
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

  Padding password() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller.password,
        cursorRadius: const Radius.circular(3),
        autocorrect: true,
        enableInteractiveSelection: true,
        obscureText: passVisible,
        cursorColor: Colors.white,
        style: const TextStyle(color: black),
        decoration: InputDecoration(
          suffixIcon: togglePassword(),
          labelText: 'Password',
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

  Widget togglePassword() {
    return GestureDetector(
      onTap: () {
        setState(() {
          passVisible = !passVisible;
        });
      },
      child: passVisible
          ? const Icon(
              Iconsax.eye_slash,
            )
          : const Icon(Iconsax.eye),
    );
  }
}

class FacebookSign extends StatelessWidget {
  const FacebookSign({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width / 1.2,
        child: ElevatedButton.icon(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(blueColor)),
          onPressed: () {},
          label: Text(
            'Facebook',
            style: GoogleFonts.aleo(color: white, fontSize: 20),
          ),
          icon: const Icon(
            FontAwesomeIcons.facebook,
            color: white,
          ),
        ));
  }
}

class GoogleSign extends StatelessWidget {
  const GoogleSign({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width / 1.2,
        child: ElevatedButton.icon(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(redColor)),
          onPressed: () {},
          label: Text(
            'Google',
            style: GoogleFonts.aleo(color: white, fontSize: 20),
          ),
          icon: const Icon(
            FontAwesomeIcons.google,
            color: white,
          ),
        ));
  }
}

sizeBox(double height) => SizedBox(height: height);
