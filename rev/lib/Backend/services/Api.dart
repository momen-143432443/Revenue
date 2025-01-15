import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.1.9/api/";

  static signUpToApp(Map pData) async {
    final url = Uri.parse("$baseUrl create user");
    try {
      final res = await http.post(url, body: pData);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Failed to get the response");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
