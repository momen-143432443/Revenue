import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:css/Backend/SceduleSturcture.dart/FetchScheduleAgent.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Loader.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ShowScheduleController extends GetxController {
  static ShowScheduleController get instance => Get.find();
  Rx<UserModel> user = UserModel.userDataEmpty().obs;
  final show = Get.put(FetchScheduleAgent());
  late Map<String, dynamic> excelSchedule;
  final firestoreSchedule = {}.obs;
  final Alerts alerts = Alerts();

  // ShowScheduleController(this.excelSchedule);
  Future<void> loadAndFetchExcelFile() async {
    try {
      Loader.startLoading();
      FetchScheduleAgent fetchScheduleAgent = FetchScheduleAgent();
      final excelSchedule = await fetchScheduleAgent.loadExcelFile();
      excelSchedule;
      Loader.stopLaoding();
    } on PlatformException catch (e) {
      Loader.stopLaoding();
      throw alerts.ifErrors(e.message.toString());
    }
  }

  String getAgentSchedule(String agentId) {
    if (excelSchedule[agentId] == user.value.hrID &&
        AuthenticationRepo.instance.authUser?.uid != null) {
      String excelScheduleData =
          excelSchedule[agentId] ?? 'No schedule available';
      String firestoreScheduleData =
          firestoreSchedule[agentId] ?? 'No schedule in Firestore';

      return "Excel Schedule: $excelScheduleData\nFirestore Schedule: $firestoreScheduleData";
    }
    return '';
  }
}
