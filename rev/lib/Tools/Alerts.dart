import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

double widthOfButton = MediaQuery.of(navigator!.context).size.width;

class Alerts {
  ifErrors(String e) =>
      ScaffoldMessenger.of(navigator!.context).showSnackBar(SnackBar(
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
              e,
              style: const TextStyle(color: redColor),
            ),
            const Text(
              '.',
              style: TextStyle(color: Colors.transparent, fontSize: 1),
            )
          ],
        ),
      ));

  userInvaild() {
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
            "There's no account with this email.",
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

  emailAlreadyUsed() {
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
            "Email Already Used.",
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

  invalidEmail() {
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
            "Email Already Used.",
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
            "Email is require.",
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

  nameLenRequrie() {
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
            "The first must be at least 6 letters",
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

  passwordIncorrect() {
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
            "Password Is Incorrect.",
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

  addItemInTheBag() {
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
            color: greenColor,
          ),
          Text(
            "Successfully added in your bag.",
            style: TextStyle(color: green),
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

  deleteItemFromTheBag() {
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
            color: greenColor,
          ),
          Text(
            "Successfully Deleted.",
            style: TextStyle(color: green),
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

  alreadyInTheBag() {
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
            "Product already in your bag.",
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

  youMustRecviveYourPreviousOrder() {
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
            "You Must Recvive Your Previous Order.",
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

  purchaseSuccessfully() {
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
            color: greenColor,
          ),
          Text(
            "Purchase Successfully",
            style: TextStyle(color: greenColor),
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

  reportSentSuccessfully() {
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
            color: greenColor,
          ),
          Text(
            "Report Sent Successfully",
            style: TextStyle(color: greenColor),
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
}
