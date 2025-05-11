import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InsertInfoOfPurchaseProduct extends GetxController {
  static InsertInfoOfPurchaseProduct get instance => Get.find();
  final RxBool purchaseSuccess = false.obs;

  final baseUrl = "http://192.168.1.2:3000/";
  GlobalKey<FormState> insertInfoOfPurchaseProductToDataBaseKey =
      GlobalKey<FormState>();
  Alerts alerts = Alerts();
  @override
  void onInit() {
    super.onInit();
    final user = AuthenticationRepo.instance.authUser?.email;
    if (user != null) {
      checkOrderStatus(user);
    }
  }

  Future<void> checkOrderStatus(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final getOrderStatusURL = "${baseUrl}getOrderStatus?userId=$userId";
    print('--------------------------');
    print("${baseUrl}getOrderStatus?userId=$userId");
    final url = Uri.parse(getOrderStatusURL);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final hasItems =
            data['items'] != null && (data['items'] as List).isNotEmpty;
        purchaseSuccess.value = hasItems;
        await prefs.setBool('check_purchase_success', hasItems);
      } else {
        purchaseSuccess.value = false;
        await prefs.setBool('check_purchase_success', false);
      }
    } catch (e) {
      print('Error checking MongoDB purchase status: $e');
      purchaseSuccess.value = false;
      await prefs.setBool('check_purchase_success', false);
    }
  }

  Future<void> purchaseProductToDataBase(String userId,
      List<Map<String, dynamic>> items, String totalOfOrder) async {
    final insertInfoOfPurchase = "${baseUrl}insertInfoOfPurchase";
    try {
      Loader.startLoading();

      final url = Uri.parse(insertInfoOfPurchase);
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {"userId": userId, "items": items, "Total": totalOfOrder}));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        print('CHECKING ORDER STATUS FOR USER ID: $userId');
        // await savePurchaseStatus(true); //Save button status
        await checkOrderStatus(userId);
        Loader.stopLoading();
        Get.back();
        alerts.purchaseSuccessfully();
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
