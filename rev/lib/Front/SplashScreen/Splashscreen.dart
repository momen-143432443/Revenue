import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: SizedBox(
        child: Center(
          child: Text(
            'R',
            style: GoogleFonts.italianno(
                fontSize: 150, color: greenColor, fontWeight: FontWeight.w500),
          ),
        ),
      )),
    );
  }
}
