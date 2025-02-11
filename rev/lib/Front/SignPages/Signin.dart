import 'package:css/Backend/Controllers/SignInContoller.dart';
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
              const SizedBox(height: 15),
              const Password(),
              sizeBox(10),
              const ForgetPassword(),
              sizeBox(45),
              Continue(width: width),
              const Divider(),
              const TryToQuickSign(),
              sizeBox(15),
              GoogleSign(width: width),
              const SizedBox(height: 5),
              FacebookSign(width: width),
              sizeBox(100),
              sizeBox(height / 22),
              const PushToSignUp()
            ],
          ),
        ),
      )),
    );
  }
}

class TryToQuickSign extends StatelessWidget {
  const TryToQuickSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Try to quick sign",
      style: GoogleFonts.aleo(fontWeight: FontWeight.w600),
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
              style: GoogleFonts.aleo(color: lime, fontWeight: FontWeight.w600),
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
                backgroundColor: WidgetStatePropertyAll(grey)),
            onPressed: () async => await controller.signInTrigger(),
            child: Text(
              'Continue',
              style: GoogleFonts.aleo(color: black),
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
