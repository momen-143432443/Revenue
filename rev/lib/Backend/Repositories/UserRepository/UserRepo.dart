import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:get/get.dart';

class UserRepo extends GetxController {
  static UserRepo get to => Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Store user in Firebase
  Future<void> saveUserRecords(UserModel user) async {
    try {
      await db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      e.message.toString();
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<UserModel> fetchUserRecords() async {
    try {
      final document = await db
          .collection("Users")
          .doc(AuthenticationRepo().authUser?.uid)
          .get();
      if (document.exists) {
        return UserModel.fromSnapshot(document);
      } else {
        return UserModel.userDataEmpty();
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }
}
