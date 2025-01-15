import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:css/Backend/Repositories/UserRepository/UserRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  Rx<UserModel> user = UserModel.userDataEmpty().obs;
  final showUserData = Get.put(UserRepo());
  final userRepo = Get.put(UserRepo());
  @override
  void onInit() {
    super.onInit(); // Call super if required by the library
    fetchUserData();
  }

  Future<UserModel> fetchUserData() async {
    return await showUserData.fetchUserRecords();
  }

  // Save user record from ang Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh receords
      await fetchUserData();
      if (user.value.id!.isEmpty) {
        if (userCredentials != null) {
          // Convert name to first name and last name

          final user = UserModel(
              id: userCredentials.user?.uid,
              hrID: '',
              email: userCredentials.user?.email,
              password: '',
              firstName: '',
              lastName: '');
          await userRepo.saveUserRecords(user);
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
