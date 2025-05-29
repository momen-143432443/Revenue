import 'dart:convert';

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ShowAllItems extends GetxController {
  static ShowAllItems get instance => Get.find();
  Rx<RevenueIemsModel> user = RevenueIemsModel.cartEmpty().obs;
  List<RevenueIemsModel> items = [];
  final baseURL = 'http://192.168.1.12:3000/';
  GlobalKey<FormState> showAllItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();

  @override
  void onInit() {
    super.onInit(); // Call super if required by the library
    fetchAllItem().then((fetchedItems) {
      items = fetchedItems;
      update();
    });
  }

  Future<List<RevenueIemsModel>> fetchAllItem() async {
    final getAllItem = "${baseURL}FetchProductsMostOfTrindingToUser";
    final url = Uri.parse(getAllItem);
    try {
      final response = await http.get(url);
      print('RESPONSE BODY: ${response.body}');
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final itemsData =
            data.map((json) => RevenueIemsModel.fromOracleMap(json)).toList();
        items = itemsData;
        return itemsData;
      } else {
        throw alerts.ifErrors("Nothing To Show, Please Try Later");
      }
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      throw e.toString();
    }
  }
}
