import 'package:css/Front/GeneralPages/Community.dart';
import 'package:css/Front/GeneralPages/Home.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int index = 0;
  final pages = [const Home(), const Community()];
  final homeText = GoogleFonts.balooDa2(color: blueColor);
  final notiText = GoogleFonts.balooDa2(color: blueColor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: MoltenBottomNavigationBar(
        domeCircleSize: 45,
        barHeight: 50,
        borderSize: 1,
        margin: const EdgeInsets.only(bottom: 2),
        borderRaduis: BorderRadius.circular(22),
        duration: const Duration(milliseconds: 400),
        borderColor: skyer,
        curve: Curves.ease,
        domeCircleColor: skyer,
        domeHeight: 1,
        tabs: [
          MoltenTab(
            icon: const Icon(Iconsax.home),
            selectedColor: Colors.white,
            unselectedColor: skyer,
            title: Text(
              'Home',
              style: homeText,
            ),
          ),
          MoltenTab(
            icon: const Icon(Icons.public_rounded),
            title: Text(
              "Community",
              style: notiText,
            ),
            selectedColor: Colors.white,
            unselectedColor: skyer,
          ),
        ],
        selectedIndex: index,
        onTabChange: (indexs) {
          setState(() {
            index = indexs;
          });
        },
      ),
    );
  }
}
