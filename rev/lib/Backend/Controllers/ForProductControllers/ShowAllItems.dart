import 'dart:convert';

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const baseURL = 'http://192.168.1.7:3000/';

class ShowAllItemsMostOfTrinding extends GetxController {
  static ShowAllItemsMostOfTrinding get instance => Get.find();
  List<RevenueIemsModel> items = [];

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
    const getAllItem = "${baseURL}FetchProductsMostOfTrindingToUser";
    final url = Uri.parse(getAllItem);
    try {
      final response = await http.get(url);
      // print('RESPONSE BODY: ${response.body}');
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

class ShowAllItemsShoesProducts extends GetxController {
  static ShowAllItemsShoesProducts get instance => Get.find();
  List<RevenueIemsModel> shoesItems = [];
  GlobalKey<FormState> showAllShoesItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  Future<List<RevenueIemsModel>> fetchAllItems() async {
    const getAllItems = "${baseURL}FetchProductsShoeItemsToUser";
    final url = Uri.parse(getAllItems);
    try {
      final res = await http.get(url);
      // print('RESPONSE BODY OF SHOE ITEMS: ${res.body}');
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        final itemsData =
            data.map((shoes) => RevenueIemsModel.fromOracleMap(shoes)).toList();
        shoesItems = itemsData;
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

class ShowFeatureItems extends GetxController {
  static ShowAllItemsShoesProducts get instance => Get.find();
  List<RevenueIemsModel> featuresItems = [];
  GlobalKey<FormState> showAllShoesItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  Future<List<RevenueIemsModel>> fetchAllItems() async {
    const getAllItems = "${baseURL}FetchAllItemsFeatureItem";
    final url = Uri.parse(getAllItems);
    try {
      final res = await http.get(url);
      // print('RESPONSE BODY OF SHOE ITEMS: ${res.body}');
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        final itemsData =
            data.map((shoes) => RevenueIemsModel.fromOracleMap(shoes)).toList();
        featuresItems = itemsData;
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

class ShowNewItems extends GetxController {
  static ShowAllItemsShoesProducts get instance => Get.find();
  List<RevenueIemsModel> newItems = [];
  GlobalKey<FormState> showAllNewItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  Future<List<RevenueIemsModel>> fetchAllItems() async {
    const getAllItems = '${baseURL}FetchNewItemsToUser';
    final url = Uri.parse(getAllItems);
    try {
      final res = await http.get(url);
      print('RESPONSE BODY OF SHOE ITEMS: ${res.body}');
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        final itemsData =
            data.map((shoes) => RevenueIemsModel.fromOracleMap(shoes)).toList();
        newItems = itemsData;
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
