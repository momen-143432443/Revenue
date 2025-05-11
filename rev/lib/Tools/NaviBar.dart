import 'package:css/Front/GeneralPages/Cart.dart';
import 'package:css/Front/GeneralPages/Home.dart';
import 'package:css/Front/GeneralPages/Profile.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int index = 0;
  final pages = [const Home(), const Cart(), const Profile()];
  final homeText = GoogleFonts.balooDa2(color: black);
  final notiText = GoogleFonts.balooDa2(color: black);
  final profileText = GoogleFonts.balooDa2(color: black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: white,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            color: greenColor,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.fastOutSlowIn,
            height: 45,
            items: const [
              Icon(
                Iconsax.shop,
                color: white,
              ),
              Icon(
                Iconsax.shopping_cart,
                color: white,
              ),
              Icon(
                Iconsax.user,
                color: white,
              )
            ]));
  }
}
