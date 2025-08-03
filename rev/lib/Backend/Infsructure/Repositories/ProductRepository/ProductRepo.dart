import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final alerts = Alerts();
  final user = AuthenticationRepo.instance.auth.currentUser?.uid;
  final userEmail = AuthenticationRepo.instance.auth.currentUser?.email;
  Future<void> addItemsToStore(RevenueIemsModel rev) async {
    try {
      await db.collection("Cart").doc(user).set({
        "email": AuthenticationRepo.instance.auth.currentUser?.email,
        "items": FieldValue.arrayUnion([rev.toCartJson()])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteOrderInTheBagToTransferringIntoProcessingPage() async {
    try {
      await db.collection('Cart').doc(user).delete();
      print(db.collection('Cart').doc(user).delete() == null);
    } on FirebaseException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } on PlatformException catch (e) {
      throw alerts.ifErrors(e.message.toString());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RevenueIemsModel>> getItemsInCart() async {
    try {
      final snap = await db
          .collection("Cart")
          .where("email", isEqualTo: userEmail)
          .get();

      if (snap.docs.isEmpty) return [];

      // `data()` returns a Map<String, dynamic> — this is fine
      final cartData = snap.docs.first.data();

      final cartList = cartData['items'] as List;

      final items = cartList
          .map((item) => RevenueIemsModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return items;
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> removeItemsFromCart(String id) async {
    try {
      final snap = await db
          .collection("Cart")
          .where("email",
              isEqualTo: AuthenticationRepo.instance.auth.currentUser?.email)
          .get();
      if (snap.docs.isEmpty) return;
      final doc = snap.docs.first;
      final cartList = List<Map<String, dynamic>>.from(doc.data()['items']);
      cartList.removeWhere((order) => order['itemId'].toString() == id);
      await db.collection("Cart").doc(doc.id).update({'items': cartList});
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong, please try again';
    }
  }
}
