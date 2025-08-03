import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Front/CustomerService/Chats.dart';
import 'package:css/Front/CustomerService/ReportsAndFeedbackFromCustomerpages.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

const SizedBox spaceBetweenExpansionButtons = SizedBox(height: 10);

class CustomerServicePage extends StatefulWidget {
  const CustomerServicePage({super.key});

  @override
  State<CustomerServicePage> createState() => _CustomerserviSePageState();
}

class _CustomerserviSePageState extends State<CustomerServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              howWouldYouLikeToServeYou(),
              spaceBetweenExpansionButtons,
              spaceBetweenExpansionButtons,
              const ServiceOptions(),
            ],
          ),
        )));
  }

  Column howWouldYouLikeToServeYou() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 120),
          child: Text(
            "How Would You Like To Serve You.",
            style: GoogleFonts.aleo(
                fontSize: 17, color: black, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

class ServiceOptions extends StatelessWidget {
  const ServiceOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            phonenumberService(),
            spaceBetweenExpansionButtons,
            spaceBetweenExpansionButtons,
            chatService(),
            spaceBetweenExpansionButtons,
            spaceBetweenExpansionButtons,
            sendReports(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            phonenumberServiceButton(),
            spaceBetweenExpansionButtons,
            spaceBetweenExpansionButtons,
            chatServiceButton(),
            spaceBetweenExpansionButtons,
            spaceBetweenExpansionButtons,
            sendReportsButton(),
          ],
        )
      ],
    );
  }

  GestureDetector sendReportsButton() {
    return GestureDetector(
      onTap: () => getx.Get.to(
          () => const ReportSendFeedbackFromCustomerPages(),
          transition: getx.Transition.rightToLeft),
      child: const Icon(
        Iconsax.arrow_right_3,
        size: 16,
      ),
    );
  }

  GestureDetector chatServiceButton() {
    final String? user = AuthenticationRepo.instance.authUser?.uid;
    return GestureDetector(
      onTap: () => getx.Get.to(
          () => Chats(senderId: user!, receiverId: 'Customer Service'),
          transition: getx.Transition.rightToLeft),
      child: const Icon(
        Iconsax.arrow_right_3,
        size: 16,
      ),
    );
  }

  Text phonenumberServiceButton() {
    return Text(
      "+${962064444}",
      style: GoogleFonts.aleo(
          fontSize: 15, color: black, fontWeight: FontWeight.w500),
    );
  }

  GestureDetector sendReports() {
    return GestureDetector(
      onTap: () => getx.Get.to(
          () => const ReportSendFeedbackFromCustomerPages(),
          transition: getx.Transition.rightToLeft),
      child: Text(
        "Send Report&Feedback",
        style: GoogleFonts.aleo(
            fontSize: 15, color: black, fontWeight: FontWeight.w500),
      ),
    );
  }

  GestureDetector chatService() {
    final String? user = AuthenticationRepo.instance.authUser?.uid;
    return GestureDetector(
      onTap: () {
        if (user != null) {
          getx.Get.to(
              () => Chats(senderId: user, receiverId: 'Customer Service'),
              transition: getx.Transition.rightToLeft);
        } else {
          getx.Get.snackbar('Error', 'You must be logged in to chat');
        }
      },
      child: Text(
        "Chat Now!",
        style: GoogleFonts.aleo(
            fontSize: 15, color: black, fontWeight: FontWeight.w500),
      ),
    );
  }

  Text phonenumberService() {
    return Text(
      "Phone number",
      style: GoogleFonts.aleo(
          fontSize: 15, color: black, fontWeight: FontWeight.w500),
    );
  }
}
