import 'package:animate_do/animate_do.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignUpConroller.dart';
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
  bool passVisible = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              sizeBox(50),
              Revenues(
                width: width,
                height: height,
              ),
              sizeBox(50),
              signUpGetStarted(width),
              insertInfoTextFields(),
              sizeBox(145),
              const PushToSignIn()
            ],
          ),
        ),
      )),
    );
  }

  FadeInLeft insertInfoTextFields() {
    return FadeInLeft(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            sizeBox(10),
            const Email(),
            sizeBox(15),
            password(),
            sizeBox(15),
            const FirstnameAndLastName(),
            sizeBox(45),
            const SaveAndContinue(),
            sizeBox(10),
          ],
        ),
      ),
    );
  }

  FadeInLeft signUpGetStarted(double size) {
    return FadeInLeft(
      child: Container(
        margin: EdgeInsets.only(
          top: size / 8.83,
        ),
        child: Container(
          margin: EdgeInsets.only(left: size / 12),
          width: size,
          child: Text("Sign Up, Get Started",
              style: GoogleFonts.aleo(
                  fontSize: 35, color: white, fontWeight: FontWeight.w600)),
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
        autocorrect: passVisible,
        enableInteractiveSelection: true,
        obscureText: true,
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
              color: white,
            )
          : const Icon(
              Iconsax.eye,
              color: white,
            ),
    );
  }
}

class PushToSignIn extends StatelessWidget {
  const PushToSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already Have An Account? "),
            GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  "Press here to sign in",
                  style: GoogleFonts.aleo(
                      color: white, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
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
                suffixIcon: const Icon(Iconsax.user, color: white),
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
                suffixIcon: const Icon(Iconsax.user, color: white),
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
        cursorColor: white,
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
}

class Revenues extends StatelessWidget {
  const Revenues({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: SizedBox(
        width: width / 1.2,
        height: height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'R',
              style: GoogleFonts.italianno(
                  fontSize: 115, color: white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

sizeBox(double height) => SizedBox(height: height);
