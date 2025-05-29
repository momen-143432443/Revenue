import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchbarController extends GetxController {
  static SearchbarController get instance => Get.find();

  final Rx<TextEditingController> searchController =
      TextEditingController().obs;

  List<RevenueIemsModel> allItems = [
    ...mostTrending,
    ...itemsFeatures,
    ...newItemsOfRev,
    ...shoesSection
  ];

  RxList<RevenueIemsModel> filteredItems = <RevenueIemsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.value
        .addListener(() => filtersItems(searchController.value.text));
    filteredItems.value = allItems;
    update();
  }

  void filtersItems(String query) {
    final lowerQuery = query.toLowerCase();
    filteredItems.value = allItems.where((item) {
      return item.name.toLowerCase().contains(lowerQuery) ||
          item.model.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
