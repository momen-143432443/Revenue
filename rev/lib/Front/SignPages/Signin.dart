import 'package:css/Backend/Controllers/ForUserControllers/SignInContoller.dart';
import 'package:css/Front/SignPages/SendOTPToUser.dart';
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
      backgroundColor: greenColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              sizeBox(50),
              Revenue(width, height),
              // revenueIcon(width, height),
              sizeBox(50),
              signInText(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    sizeBox(10),
                    email(),
                    sizeBox(15),
                    // const SizedBox(height: 15),
                    password(),
                    sizeBox(10),
                    forgetPassword(),
                    sizeBox(45),
                    saveAndContinue(width),
                    const Divider(),
                    tryToQuickSign(),
                    sizeBox(15),
                    GoogleSign(width: width),
                    sizeBox(5),
                    // const SizedBox(height: 5),
                    FacebookSign(width: width),
                    sizeBox(10),
                  ],
                ),
              ),
              sizeBox(40),
              ceatingNewAccount()
            ],
          ),
        ),
      )),
    );
  }

  Padding signInText() {
    return Padding(
      padding: const EdgeInsets.only(top: 45, right: 233),
      child: Text("Sign In",
          style: GoogleFonts.aleo(
              fontSize: 45, color: white, fontWeight: FontWeight.w600)),
    );
  }

  SizedBox Revenue(double width, double height) {
    return SizedBox(
      width: width / 1.2,
      height: height / 5,
      child: Center(
        child: Text(
          'R',
          style: GoogleFonts.italianno(
              fontSize: 115, color: white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Container ceatingNewAccount() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          GestureDetector(
              onTap: () => Get.to(() => const Signup()),
              child: Text(
                "Press here to sign up",
                style:
                    GoogleFonts.aleo(color: white, fontWeight: FontWeight.w600),
              ))
        ],
      ),
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
        onTap: () {
          print('push to forget password');
          Get.to(() => const SendOTPToUser());
        },
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
              color: white,
            )
          : const Icon(
              Iconsax.eye,
              color: white,
            ),
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
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Container(
          width: width / 2.4,
          height: size.height / 26,
          decoration: BoxDecoration(
              color: blueColor, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  FontAwesomeIcons.facebook,
                  color: white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  "Facebook",
                  style: GoogleFonts.aleo(
                      fontSize: 20, color: white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          )),
    );
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
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async => await controller.googleSignIn(),
      child: Container(
          decoration: BoxDecoration(
              color: redColor, borderRadius: BorderRadius.circular(30)),
          width: width / 3,
          height: size.height / 26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  FontAwesomeIcons.google,
                  color: white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  "Google",
                  style: GoogleFonts.aleo(
                      fontSize: 20, color: white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
          // IconButton(
          //   style: const ButtonStyle(
          //       backgroundColor: WidgetStatePropertyAll(redColor)),
          //   onPressed: () {},
          //   icon: const Icon(
          //     FontAwesomeIcons.google,
          //     color: white,
          //   ),
          // )
          ),
    );
  }
}

sizeBox(double height) => SizedBox(height: height);
