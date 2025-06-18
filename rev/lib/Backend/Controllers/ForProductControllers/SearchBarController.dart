import 'dart:async';
import 'dart:convert';
import 'package:css/Backend/Controllers/ForUserControllers/BaseUrl.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchbarController extends GetxController {
  static SearchbarController get instance => Get.find();
  final searchItem = '${baseURL}FetchSpecificItemFromSearchBar?query=';
  var query = ''.obs;

  final TextEditingController searchController = TextEditingController();
  List<SearchItemModel> searchResults = [];
  RxList<SearchItemModel> filteredItems = <SearchItemModel>[].obs;

  Timer? debounce;
  @override
  void onInit() {
    super.onInit();
    // Whenever text changes, call filtersItems()
    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(
        const Duration(milliseconds: 300),
        () {
          final currnetQuery = searchController.value.text.trim();
          filtersItems(currnetQuery);
        },
      );
    });
  }

  void onQueryChanged(String value) {
    query.value = value;
    filtersItems(value);
    // optional: filter or fetch from backend
  }

  Future<void> filtersItems(String query) async {
    // / 1) If the field is empty, just clear the results immediately
    if (query.isEmpty) {
      filteredItems.clear();
      return;
    }
    // 2) Build the URI and call your Node endpoint
    final url =
        Uri.parse('$searchItem${Uri.encodeQueryComponent(query.trim())}');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });
      print(" search‐API returned: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        searchResults = jsonList
            .map((data) => SearchItemModel.fromSearchMap(data))
            .toList();
        filteredItems.assignAll(searchResults);
      } else {
        filteredItems.clear();
      }
    } catch (e) {
      print("Error: $e");
      filteredItems.clear();
    }
  }
}
