import 'dart:async';
import 'dart:convert';
import 'package:css/Backend/BaseUrl.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MoreSectionController extends GetxController {
  static MoreSectionController get instance => Get.find();
  List<RevenueIemsModel> items = [];
  RxList<RevenueIemsModel> moreItems = <RevenueIemsModel>[].obs;
  GlobalKey<FormState> showAllItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    fetchMoreSection();
    update();
  }

  Future<void> fetchMoreSection() async {
    const moreSection = "${baseURL}FetchItemsInMoreSection";
    final url = Uri.parse(moreSection);
    try {
      final res = await http.get(url);
      // print('RESPONSE BODY FROM MORE SECTION: ${res.body}');
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        final List data = decoded['result'];
        final allMoreSctionItems =
            data.map((e) => RevenueIemsModel.fromOracleMap(e)).toList();
        allMoreSctionItems.shuffle();
        items = allMoreSctionItems;
        moreItems.assignAll(items);
      } else {
        alerts.ifErrors("Nothing To Show, Please Try Later");
        // return [];
      }
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      rethrow;
    }
  }
}

class OfferItems extends GetxController {
  static OfferItems get instance => Get.find();
  List<RevenueIemsModel> items = [];
  RxList<RevenueIemsModel> offerItems = <RevenueIemsModel>[].obs;
  GlobalKey<FormState> showAllItems = GlobalKey<FormState>();
  Alerts alerts = Alerts();
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    fetchMoreSection();
    update();
  }

  Future<void> fetchMoreSection() async {
    const offerSection = "${baseURL}FetchOfferitems";
    final url = Uri.parse(offerSection);
    try {
      final res = await http.get(url);
      // print('RESPONSE BODY FROM OFFER SECTION: ${res.body}');
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        final List data = decoded;
        final allMoreSctionItems =
            data.map((e) => RevenueIemsModel.fromOracleMap(e)).toList();
        allMoreSctionItems.shuffle();
        items = allMoreSctionItems;
        offerItems.assignAll(items);
      } else {
        alerts.ifErrors("Nothing To Show, Please Try Later");
        // return [];
      }
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      rethrow;
    }
  }
}
