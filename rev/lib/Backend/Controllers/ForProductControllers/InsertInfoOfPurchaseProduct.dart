import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:css/Backend/Controllers/ForUserControllers/BaseUrl.dart';

class InsertInfoOfPurchaseProduct extends GetxController {
  static InsertInfoOfPurchaseProduct get instance => Get.find();
  final RxBool purchaseSuccess = true.obs;

  GlobalKey<FormState> insertInfoOfPurchaseProductToDataBaseKey =
      GlobalKey<FormState>();
  Alerts alerts = Alerts();
  @override
  void onInit() {
    super.onInit();
    final user = AuthenticationRepo.instance.authUser;
    if (user != null) {
      checkOrderStatus(user.uid);
    }
  }

  Future<void> clearPurchaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('check_purchase_success');
    purchaseSuccess.value = false;
  }

  Future<void> checkOrderStatus(String userId) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('checkPurchaseSuccess');
    final getOrderStatusURL = "${baseURL}getOrderStatus?userId=$userId";
    // print('--------------------------');3
    // print("${baseURL}getOrderStatus?userId=$userId");
    final url = Uri.parse(getOrderStatusURL);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['items'];
        final hasItems = items != null && items is List && items.isNotEmpty;
        purchaseSuccess.value = hasItems;
        // await prefs.setBool('check_purchase_success', hasItems);
      } else {
        purchaseSuccess.value = false;
        // await prefs.setBool('check_purchase_success', false);
      }
    } catch (e) {
      print('Error checking MongoDB purchase status: $e');
      purchaseSuccess.value = false;
      // await prefs.setBool('check_purchase_success', false);
    }
  }

  Future<void> purchaseProductToDataBase(String userId,
      List<Map<String, dynamic>> items, double totalOfOrder) async {
    const insertInfoOfPurchase = "${baseURL}insertInfoOfPurchase";
    try {
      SafeTap.execute(
        context: navigator!.context,
        onTap: () async {},
      );
      Loader.startLoading();

      final url = Uri.parse(insertInfoOfPurchase);
      print("🛒 Inserting items for userId: $userId");
      print("Items: $items");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {"userId": userId, "items": items, "totalPrice": totalOfOrder}));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        print('CHECKING ORDER STATUS FOR USER ID: $userId');
        await Future.delayed(const Duration(milliseconds: 300));

        await checkOrderStatus(userId);
        Loader.stopLoading();
        alerts.purchaseSuccessfully();
        Get.back();
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
