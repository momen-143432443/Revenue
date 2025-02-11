import 'package:css/Backend/Controllers/SignUpConroller.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

final controller = Get.put(SignupConroller());

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Column(
            children: [
              sizeBox(50),
              CsSwaps(
                width: width,
                height: height,
              ),
              sizeBox(100),
              const Email(),
              sizeBox(15),
              const Password(),
              sizeBox(15),
              const FirstnameAndLastName(),
              sizeBox(45),
              const SaveAndContinue(),
              sizeBox(235),
              const PushToSignIn()
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
          style:
              const ButtonStyle(backgroundColor: WidgetStatePropertyAll(grey)),
          onPressed: () async => await controller.signUpTrigger(),
          child: Text(
            'Save & continue',
            style: GoogleFonts.aleo(color: black),
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
                suffixIcon: const Icon(Iconsax.user, color: black),
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
                suffixIcon: const Icon(Iconsax.user, color: black),
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
          suffixIcon: const Icon(Iconsax.lock, color: black),
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
}

class CsSwaps extends StatelessWidget {
  const CsSwaps({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 1.2,
      height: height / 7 + 26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'R',
            style: GoogleFonts.italianno(
                fontSize: 115, color: lime, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

sizeBox(double height) => SizedBox(height: height);
