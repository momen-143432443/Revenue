import 'dart:convert';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:css/Backend/BaseUrl.dart';

class InsertInfoOfPurchaseProduct extends getx.GetxController {
  static InsertInfoOfPurchaseProduct get instance => getx.Get.find();
  final getx.RxBool purchaseSuccess = true.obs;
  final ifTheresOrderProcessing = getx.Get.put(OrderUnderProcessing());
  GlobalKey<FormState> insertInfoOfPurchaseProductToDataBaseKey =
      GlobalKey<FormState>();
  Alerts alerts = Alerts();

  Future<void> purchaseProductToDataBase(String userId,
      List<Map<String, dynamic>> items, double totalOfOrder) async {
    const insertInfoOfPurchase = "${baseURL}insertInfoOfPurchase";
    if (ifTheresOrderProcessing.orderUnderProcesing.isNotEmpty) {
      print(
          'processing status ${ifTheresOrderProcessing.orderUnderProcesing.isNull}');
      alerts.youMustRecviveYourPreviousOrder();
      alerts.purchaseSuccessfully();
      getx.Get.back();
    } else if (ifTheresOrderProcessing.orderUnderProcesing.isEmpty) {
      try {
        SafeTap.execute(
          context: getx.navigator!.context,
          onTap: () async {},
        );
        Loader.startLoading();

        final url = Uri.parse(insertInfoOfPurchase);
        print("🛒 Inserting items for userId: $userId");
        print("Items: $items");
        final response = await http.post(url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              "userId": userId,
              "items": items,
              "totalPrice": totalOfOrder
            }));
        final data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['status'] == true) {
          print('CHECKING ORDER STATUS FOR USER ID: $userId');
          await Future.delayed(const Duration(milliseconds: 300));

          // await checkOrderStatus(userId);
          Loader.stopLoading();
          alerts.purchaseSuccessfully();
          getx.Get.back();
        } else if (data['status'] == false) {
          // await savePurchaseStatus(false);
          alerts.ifErrors("Purchase failed. Try again.");
        }
      } on PlatformException catch (e) {
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      }
    }
  }
}
