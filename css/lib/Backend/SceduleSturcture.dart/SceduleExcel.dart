import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> agentScedule(String hr_ID) async {
  var file = await loadExcelFile();
  final sheet = file.tables.values.first;
  Rx<UserModel> user = UserModel.userDataEmpty().obs;

  if (sheet == true) {
    for (var rows in sheet.rows) {
      if (rows.isNotEmpty && rows[0] == hr_ID && user.value.hrID == hr_ID) {
        print(user.value.hrID);
        print("Schedule for agent $hr_ID: $rows");
        rows.first;
      }
    }
  }
}

Future<Excel> loadExcelFile() async {
  final ByteData data = await rootBundle.load('assets/AgentScedule.xlsx');
  final List<int> bytes = data.buffer.asUint8List();
  final excel = Excel.decodeBytes(bytes);
  return excel;
}
