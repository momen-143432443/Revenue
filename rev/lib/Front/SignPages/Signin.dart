import 'package:css/Backend/Controllers/SignInContoller.dart';
import 'package:css/Front/SignPages/SignUp.dart';
import 'package:css/Tools/Colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as math;

final controller = Get.put(SigninContoller());

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const CsSwaps(),
              const SizedBox(height: 100),
              const Email(),
              const SizedBox(height: 15),
              const Password(),
              const SizedBox(height: 10),
              const ForgetPassword(),
              const SizedBox(height: 45),
              Continue(width: width),
              const SizedBox(height: 345),
              const PushToSignUp()
            ],
          ),
        ),
      )),
    );
  }
}

class PushToSignUp extends StatelessWidget {
  const PushToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
            onTap: () => Get.to(() => const Signup()),
            child: Text(
              "Press here to sign up",
              style:
                  GoogleFonts.aleo(color: skyer, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}

class Continue extends StatelessWidget {
  const Continue({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width / 1.2,
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(blueColor)),
            onPressed: () async => await controller.signInTrigger(),
            child: Text(
              'Continue',
              style: GoogleFonts.aleo(color: white),
            )));
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print('push to forget password'),
        child: Padding(
          padding: const EdgeInsets.only(left: 235),
          child: Text('Forget password ?', style: GoogleFonts.aleo()),
        ));
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller.password,
        cursorRadius: const Radius.circular(3),
        autocorrect: true,
        enableInteractiveSelection: true,
        obscureText: true,
        cursorColor: Colors.white,
        style: const TextStyle(color: black),
        decoration: InputDecoration(
          suffixIcon: const Icon(Iconsax.lock, color: skyer),
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
}

class Email extends StatelessWidget {
  const Email({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          suffixIcon: const Icon(Icons.email_outlined, color: skyer),
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
}

class CsSwaps extends StatelessWidget {
  const CsSwaps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 270,
        bottom: 14,
        child: Transform.rotate(
          angle: math.pi / 17,
          child: const Icon(
            size: 40,
            Iconsax.headphone5,
            color: skyer,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CS',
            style: GoogleFonts.aleo(fontSize: 24, color: csGrey),
          ),
          Text(
            'Swaps',
            style: GoogleFonts.aleo(
                fontSize: 35, color: skyer, fontWeight: FontWeight.w600),
          )
        ],
      ),
    ]);
  }
}
