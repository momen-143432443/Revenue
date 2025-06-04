import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/Infsructure/Repositories/ProductRepository/ProductRepo.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:css/Tools/Alerts.dart';

class AppMethods extends GetxController {
  static AppMethods get instance => Get.find();
  final items = <Map<String, dynamic>>[].obs;
  RxList<RevenueIemsModel> cartItems = <RevenueIemsModel>[].obs;
  final cartItemsRepo = Get.put(ProductRepo());
  Alerts alerts = Alerts();

  @override
  void onInit() {
    super.onInit(); // Call super if required by the library
    getCartItems();
  }

  Future<void> saveItemsToTheCart(RevenueIemsModel rev) async {
    final contains = itemsInBag.any((item) => item.id == rev.id);
    if (contains) {
      // Item in the bag
      alerts.alreadyInTheBag();
    } else {
      try {
        // itemsInBag.add(rev);
        await cartItemsRepo.addItemsToStore(rev);
        Get.back();
        alerts.addItemInTheBag();
      } on FirebaseException catch (e) {
        print(e.toString());
      } on PlatformException catch (e) {
        print(e.toString());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<RevenueIemsModel>> getCartItems() async {
    // Loader.startLoading();
    final fetchItems = await cartItemsRepo.getItemsInCart();
    print(fetchItems);
    return fetchItems;
  }

  Future<void> removeItems(String itemId) async {
    try {
      await cartItemsRepo.removeItemsFromCart(itemId);
      itemsInBag.removeWhere((product) => product.id == itemId);
      alerts.deleteItemFromTheBag();
      // List<RevenueIemsModel> items = await cartItemsRepo.getItemsInCart();
      // cartItems.assignAll(items);
    } catch (e) {
      rethrow;
    }
  }
}

class ItemCounts {
  // ItemCounts._();
  // static int doItemCounts = 0;
  // static totalPriceWithTax() {
  //   int tax = 16;
  //   final sumOfTotal = tax + ItemCounts.totalPriceWithQuantityOfItems();
  //   return sumOfTotal;
  // }

  // static totalPriceWithQuantityOfItems() {
  //   double totalPrice = 0.0;
  //   for (var items in itemsInBag) {
  //     totalPrice += items.price * items.countOfItem;
  //   }
  //   return totalPrice;
  // }

  static Future<List<String>> getItemsFromTheCart() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Get the existing cart from SharedPreferences
    List<String> cartList = pref.getStringList('saveItemsInBag') ?? [];

    return cartList;
  }

  static void deleteItemsFromCart(int? item) {
    itemsInBag.removeWhere((element) => element.id == item);
  }
}

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
