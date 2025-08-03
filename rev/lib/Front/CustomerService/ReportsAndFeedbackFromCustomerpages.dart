import 'package:css/Backend/Controllers/ForCustomerServiceControllers/CustomerServiceController.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';

class ReportSendFeedbackFromCustomerPages extends StatefulWidget {
  const ReportSendFeedbackFromCustomerPages({super.key});

  @override
  State<ReportSendFeedbackFromCustomerPages> createState() =>
      _ReportSendFeedbackFromCustomerPagesState();
}

class _ReportSendFeedbackFromCustomerPagesState
    extends State<ReportSendFeedbackFromCustomerPages> {
  @override
  Widget build(BuildContext context) {
    final contoller = getx.Get.put(SendReportsFromCustomerService());

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Form(
              child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  maxLines: 7,
                  maxLength: 600,
                  controller: contoller.textEditingController,
                  cursorRadius: const Radius.circular(3),
                  autocorrect: true,
                  enableInteractiveSelection: true,
                  cursorColor: white,
                  style: const TextStyle(color: black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 126, 126)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: const Color.fromARGB(255, 222, 222, 222),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Send chat Reports',
                      style: GoogleFonts.aleo(
                          fontWeight: FontWeight.w500, color: black),
                    ),
                    SizedBox(
                      width: size.width / 3,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(blueColor)),
                          onPressed: () async => await contoller.storeReport(
                              contoller.textEditingController.text),
                          child: const Text(
                            'Send',
                            style: TextStyle(color: white),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
