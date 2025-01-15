import 'package:css/Backend/Controllers/SignUpConroller.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as math;

final controller = Get.put(SignupConroller());

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 50),
              CsSwaps(),
              SizedBox(height: 100),
              Email(),
              SizedBox(height: 15),
              Password(),
              SizedBox(height: 15),
              FirstnameAndLastName(),
              SizedBox(height: 45),
              SaveAndContinue(),
              SizedBox(height: 235),
              PushToSignIn()
            ],
          ),
        ),
      )),
    );
  }
}

class PushToSignIn extends StatelessWidget {
  const PushToSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(" have an account? "),
        GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              "Press here to sign in",
              style:
                  GoogleFonts.aleo(color: skyer, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}

class SaveAndContinue extends StatelessWidget {
  const SaveAndContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 1.2,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(blueColor)),
          onPressed: () async => await controller.signUpTrigger(),
          child: Text(
            'Save & continue',
            style: GoogleFonts.aleo(color: white),
          )),
    );
  }
}

class FirstnameAndLastName extends StatelessWidget {
  const FirstnameAndLastName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: controller.firstName,
              cursorRadius: const Radius.circular(3),
              autocorrect: true,
              enableInteractiveSelection: true,
              cursorColor: Colors.white,
              style: const TextStyle(color: black),
              decoration: InputDecoration(
                suffixIcon: const Icon(Iconsax.user, color: skyer),
                labelText: 'First name',
                labelStyle: const TextStyle(color: black),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: controller.lastName,
              cursorRadius: const Radius.circular(3),
              autocorrect: true,
              enableInteractiveSelection: true,
              cursorColor: Colors.white,
              style: const TextStyle(color: black),
              decoration: InputDecoration(
                suffixIcon: const Icon(Iconsax.user, color: skyer),
                labelText: 'Last name',
                labelStyle: const TextStyle(color: black),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
          ),
        )
      ],
    );
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
