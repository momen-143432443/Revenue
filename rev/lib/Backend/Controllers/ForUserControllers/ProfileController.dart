import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Infsructure/Models/UserModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:css/Backend/BaseUrl.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  Rx<UserModel> user = UserModel.userDataEmpty().obs;
  @override
  void onInit() {
    super.onInit(); // Call super if required by the library
    final currentEmail = AuthenticationRepo.instance.authUser?.email;
    if (currentEmail != null) {
      fetchUserData(currentEmail);
    }
  }

  Future<UserModel> fetchUserData(String email) async {
    final fetching = "${baseURL}getUserData/${Uri.encodeComponent(email)}";
    final response = await http.get(Uri.parse(fetching));
    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = json.decode(response.body);
      user.value = UserModel.fromSnapshot(jsonData);
      return user.value;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
