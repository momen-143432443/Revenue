import 'package:css/Tools/Colors.dart';
import 'package:css/Tools/NaviBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart' as getx;

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              greetingText(),
              iconGreeting(),
              greetingDescription(),
              getStartButton(size)
            ],
          ),
        ),
      )),
    );
  }

  SizedBox getStartButton(Size size) {
    return SizedBox(
      width: size.width / 1.5,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(blueColor)),
          onPressed: () => getx.Get.offAll(() => const NaviBar(),
              transition: getx.Transition.leftToRight),
          child: Text(
            "Get Start",
            style: GoogleFonts.aleo(color: white, fontWeight: FontWeight.w500),
          )),
    );
  }

  Text greetingDescription() {
    return Text(
      'You Can Start Purchasing, Earn Coupuns, Send Gifts, And Many Many things.',
      style: GoogleFonts.aleo(
          fontSize: 18, color: black, fontWeight: FontWeight.w500),
    );
  }

  Icon iconGreeting() {
    return const Icon(
      Iconsax.verify5,
      color: greenColor,
      size: 200,
    );
  }

  Text greetingText() {
    return Text(
      'Welcome To Reveunes For Global Trade',
      style: GoogleFonts.aleo(
          fontSize: 25, color: black, fontWeight: FontWeight.w500),
    );
  }
}
