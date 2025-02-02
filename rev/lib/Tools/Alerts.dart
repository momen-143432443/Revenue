import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

double widthOfButton = MediaQuery.of(navigator!.context).size.width;

class Alerts {
  ifErrors(String e) {
    return ScaffoldMessenger.of(navigator!.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.down,
      width: widthOfButton / 1.3 + 20,
      behavior: SnackBarBehavior.floating,
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.error_outline,
            color: redColor,
          ),
          Text(
            e.toString(),
            style: TextStyle(color: redColor),
          ),
          const Text(
            '.',
            style: TextStyle(color: Colors.transparent, fontSize: 1),
          )
        ],
      ),
    ));
  }

  emailRequrie() {
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
            "Eamil is require.",
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

  passwordRequrie() {
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
            "Password is require.",
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

  firstNameRequrie() {
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
            "First name is require.",
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

  lastNameRequrie() {
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
            "Last name is require.",
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

  allRequrie() {
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
            "All fields are require.",
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

  exceptions(String e) {
    return ScaffoldMessenger.of(navigator!.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.down,
      width: widthOfButton / 1.3 + 20,
      behavior: SnackBarBehavior.floating,
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.error_outline,
            color: redColor,
          ),
          Text(
            e.toString(),
            style: const TextStyle(color: redColor),
          ),
          const Text(
            '.',
            style: TextStyle(color: Colors.transparent, fontSize: 1),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
    ));
  }
}
