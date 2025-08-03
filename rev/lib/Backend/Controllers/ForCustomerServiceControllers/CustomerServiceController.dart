import 'dart:convert';
import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:css/Backend/BaseUrl.dart';
import 'package:css/Backend/Infsructure/Models/CustomerService.dart';
import 'package:get/get.dart' as getx;

class CustomerServiceController extends getx.GetxController {
  static CustomerServiceController get instance => getx.Get.find();
  final isLoading = false.obs;
  final messages = <CustomerService>[].obs;

  Future<void> sendMessages(
      String senderId, String receiverId, String message) async {
    const csControl = '${baseURL}sendMessageToCustomerService';
    try {
      final url = Uri.parse(csControl);
      if (senderId.isEmpty || receiverId.isEmpty || message.trim().isEmpty) {
        print('One or more fields are empty');
        return;
      }
      final result = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "senderId": senderId,
            "receiverId": receiverId,
            "message": message,
            "timestamp": DateTime.now().toIso8601String()
          }));
      print({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
      });
      if (result.statusCode == 200) {
        // final List data = jsonDecode(result.body);
        await fetchMessage(senderId, receiverId);
      } else {
        getx.Get.snackbar("Error", "Failed to load messages");
      }
    } catch (e) {
      getx.Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchMessage(String user, String agent) async {
    final csControl = '${baseURL}fetchMessageIntoCustomerService/$user/$agent';
    try {
      final url = Uri.parse(csControl);
      final result = await http.get(
        url,
      );
      if (result.statusCode == 200) {
        //  extract the actual list from 'data' field
        final decoded = jsonDecode(result.body);
        final List<dynamic> messageList = decoded['data'];
        print('the res ${decoded['data']}');
        messages.value =
            messageList.map((e) => CustomerService.fromMap(e)).toList();
        print("Fetching from: $csControl"); // this should show full URL
      } else {
        getx.Get.snackbar("Error", "Failed to load messages");
      }
    } catch (e) {
      getx.Get.snackbar("Error", e.toString());
    }
  }
}

class SendReportsFromCustomerService extends getx.GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final user = AuthenticationRepo.instance.authUser;
  Alerts alerts = Alerts();
  static SendReportsFromCustomerService get instance => getx.Get.find();
  Future<void> storeReport(String report) async {
    final token = await user?.getIdToken();
    const geturl = '${baseURL}storeReportFromCustomer';
    try {
      final dataReport = json.encode({'message': report});
      final url = Uri.parse(geturl);
      await http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': "Bearer $token"
              },
              body: dataReport)
          .then(
        (value) {
          Loader.startLoading();
          alerts.reportSentSuccessfully();
          getx.Get.back();
          Loader.stopLoading();
        },
      ).onError(
        (error, stackTrace) {
          alerts.ifErrors(error.toString());
          Loader.stopLoading();
        },
      );
      print(dataReport);
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } catch (e) {
      print(e.toString());
    }
  }
}
