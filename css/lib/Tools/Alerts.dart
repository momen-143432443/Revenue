import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

double widthOfButton = MediaQuery.of(navigator!.context).size.width;
ifErrors(String e) {
  return ScaffoldMessenger.of(navigator!.context).showSnackBar(SnackBar(
    dismissDirection: DismissDirection.down,
    width: widthOfButton / 1.3 + 20,
    behavior: SnackBarBehavior.floating,
    backgroundColor: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    content: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.error_outline,
          color: redColor,
        ),
        Text(
          "You need to sign up with google first.",
          style: TextStyle(color: redColor),
        ),
        Text(
          '.',
          style: TextStyle(color: Colors.transparent, fontSize: 1),
        )
      ],
    ),
    duration: const Duration(seconds: 2),
  ));
}
