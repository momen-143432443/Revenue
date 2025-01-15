import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FetchScheduleAgent extends GetxController {
  static FetchScheduleAgent get instance => Get.find();
  Rx<UserModel> user = UserModel.userDataEmpty().obs;

  Future<List<Map<String, dynamic>>> fetchAgentSchedule(
      String hrId, String cr) async {
    Excel excel = await loadExcelFile();
    Sheet sheet = excel['DC'];
    List<Map<String, dynamic>> scheduleData = [];
    for (var row in sheet.rows) {
      if (row.isNotEmpty) {
        String agentIdFromExcel = row[0]?.toString() ?? '';
        String userIdFromExcel = row[1]?.toString() ?? '';
        String schedule = row[2]?.toString() ?? '';
        if (agentIdFromExcel == user.value.hrID &&
            AuthenticationRepo.instance.authUser?.uid == true) {
          scheduleData.add({
            'agent_id': agentIdFromExcel,
            'user_id': userIdFromExcel,
            'schedule': schedule,
          });
        }
      }
    }
    return scheduleData;
  }

  Future<Excel> loadExcelFile() async {
    // Load Excel file from assets
    final byteData = await rootBundle.load('assets/AgentSchedule.xlsx');
    final buffer = byteData.buffer.asUint8List();
    // Decode Excel file
    var excel = Excel.decodeBytes(buffer);
    print(excel.isNull);
    return excel;
  }
}
