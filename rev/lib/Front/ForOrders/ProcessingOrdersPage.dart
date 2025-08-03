import 'dart:convert';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' as getx;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProcessingOrdersPage extends StatefulWidget {
  const ProcessingOrdersPage({super.key});

  @override
  State<ProcessingOrdersPage> createState() => _ProcessingOrdersPageState();
}

class _ProcessingOrdersPageState extends State<ProcessingOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final userData = getx.Get.put(ProfileController());
    final order = getx.Get.put(OrderUnderProcessing());
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text('Orders Under Processing',
            style: GoogleFonts.aleo(
                fontSize: 20, color: black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Center(child: getx.Obx(
          () {
            final user = userData.user.value;
            if (user.email == null || user.email!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Center(
                    child: LoadingAnimationWidget.progressiveDots(
                        color: lime, size: 55)),
              );
            }
            return GestureDetector(
              child: Container(
                  width: width / 1.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: grey, width: 1)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: order.orderUnderProcesing.length,
                    itemBuilder: (context, index) {
                      final item = order.orderUnderProcesing[index];
                      return GestureDetector(
                        onTap: () => showModalBottomSheet(
                          backgroundColor: white,
                          context: context,
                          builder: (context) => SizedBox(
                            height: (order.orderUnderProcesing.length * 80.0)
                                .clamp(200.0, height * 0.8),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ListTile(
                                leading: item.imgAdress.isNotEmpty
                                    ? Image.memory(
                                        base64Decode(item.imgAdress),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(item.name),
                                subtitle: Text(item.model),
                                trailing: Text('${item.price} JOD'),
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(
                            child: getx.Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' Order Number: $index',
                                  style: GoogleFonts.aleo(
                                      fontSize: 20,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                ' Items Of Orders: ${order.orderUnderProcesing.length}',
                                style: GoogleFonts.aleo(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.w400),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    ' Total Price: ${order.totalPrice.value}JOD',
                                    style: GoogleFonts.aleo(
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'More Details ',
                                    style: GoogleFonts.aleo(
                                        fontSize: 13,
                                        color: black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                      );
                    },
                  )),
            );
          },
        )),
      )),
    );
  }
}
