import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
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
            chatService(),
            spaceBetweenExpansionButtons,
            sendReports(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            phonenumberServiceButton(),
            spaceBetweenExpansionButtons,
            chatServiceButton(),
            spaceBetweenExpansionButtons,
            sendReportsButton(),
          ],
        )
      ],
    );
  }

  Icon sendReportsButton() {
    return const Icon(
      Iconsax.arrow_right_3,
      size: 16,
    );
  }

  Icon chatServiceButton() {
    return const Icon(
      Iconsax.arrow_right_3,
      size: 16,
    );
  }

  Text phonenumberServiceButton() {
    return Text(
      "+${962064444}",
      style: GoogleFonts.aleo(
          fontSize: 15, color: black, fontWeight: FontWeight.w500),
    );
  }

  Text sendReports() {
    return Text(
      "Send Report&Feedback",
      style: GoogleFonts.aleo(
          fontSize: 15, color: black, fontWeight: FontWeight.w500),
    );
  }

  Text chatService() {
    return Text(
      "Chat Now!",
      style: GoogleFonts.aleo(
          fontSize: 15, color: black, fontWeight: FontWeight.w500),
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
