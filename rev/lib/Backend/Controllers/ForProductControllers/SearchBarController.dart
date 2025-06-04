import 'dart:convert';

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchbarController extends GetxController {
  static SearchbarController get instance => Get.find();
  final baseURL =
      'http://192.168.1.7:3000/FetchSpecificItemFromSearchBar?query=';

  final Rx<TextEditingController> searchController =
      TextEditingController().obs;
  List<SearchItemModel> searchResults = [];
  RxList<SearchItemModel> filteredItems = <SearchItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Whenever text changes, call filtersItems()
    searchController.value.addListener(() {
      final currnetQuery = searchController.value.text.trim();
      filtersItems(currnetQuery);
    });
  }

  Future<void> filtersItems(String query) async {
    // / 1) If the field is empty, just clear the results immediately
    if (query.isEmpty) {
      filteredItems.clear();
      return;
    }
    // 2) Build the URI and call your Node endpoint
    final url = Uri.parse('$baseURL${Uri.encodeQueryComponent(query.trim())}');
    try {
      final response = await http.get(url);
      print(" search‐API returned: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        searchResults = jsonList
            .map((data) => SearchItemModel.fromSearchMap(data))
            .toList();
        filteredItems.value = searchResults;
      } else {
        filteredItems.clear();
      }
    } catch (e) {
      print("Error: $e");
      filteredItems.clear();
    }
  }
}
