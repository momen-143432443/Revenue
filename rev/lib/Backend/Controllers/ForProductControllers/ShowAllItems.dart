import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/BaseUrl.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
        itemsData.shuffle();
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
        itemsData.shuffle();
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
        itemsData.shuffle();
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
  static ShowNewItems get instance => Get.find();
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
      // print('RESPONSE BODY OF SHOE ITEMS: ${res.body}');
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        final itemsData =
            data.map((shoes) => RevenueIemsModel.fromOracleMap(shoes)).toList();
        itemsData.shuffle();
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

class OrderUnderProcessing extends GetxController {
  static OrderUnderProcessing get instance => Get.find();
  List<RevenueIemsModel> items = [];
  RxList<RevenueIemsModel> orderUnderProcesing = <RevenueIemsModel>[].obs;
  RxInt totalPrice = 0.obs;
  final user = AuthenticationRepo.instance.authUser?.uid;
  Alerts alerts = Alerts();
  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  Future<List<RevenueIemsModel>> fetchAllItems() async {
    final getAllItems =
        '${baseURL}deleteOrderInTheBagToTransferringIntoProcessingPage/$user';
    final url = Uri.parse(getAllItems);
    try {
      final res = await http.get(url);
      final response = jsonDecode(res.body);
      if (response['items'] is List) {
        final totalPriceRaw = response['totalPrice'];
        final List items = response['items'];

        final parsedItems = items
            .map((item) {
              try {
                return RevenueIemsModel.fromMongo(item);
              } catch (e) {
                print('Failed to parse item: $e');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<RevenueIemsModel>()
            .toList();

        print('Parsed ${parsedItems.length} items');
        orderUnderProcesing.value = parsedItems;
        totalPrice.value = totalPriceRaw;
        return parsedItems;
        // Set to state or pass to widget here
      } else {
        print('Items field is not a list or is null: ${response['items']}');
        return [];
      }
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      throw Exception('Failed to fetch orders');
    }
  }
}
