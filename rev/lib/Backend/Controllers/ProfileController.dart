import 'dart:convert';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  Rx<UserModel> user = UserModel.userDataEmpty().obs;
  final baseUrl = "http://192.168.1.6:3000/";
  @override
  void onInit() {
    super.onInit(); // Call super if required by the library
    fetchUserData();
  }

  Future<List<UserModel>> fetchUserData() async {
    final fetching = baseUrl + "getUserData";
    final getUserData = await http.get(Uri.parse(fetching));
    if (getUserData.statusCode == 200) {
      print(getUserData.body);
      List<dynamic> data = json.decode(getUserData.body);
      if (data.isEmpty) {
        return [];
      }
      return data.map((e) => UserModel.fromSnapshot(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
