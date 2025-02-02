// import 'dart:convert';
// import 'package:css/Backend/Controllers/SignUpConroller.dart';
// import 'package:http/http.dart' as http;

// class Api {
//   static const baseUrl = "http://192.168.1.9/3000/";

//   static signUpToApp(Map pData) async {
//     const resgistration = baseUrl + "registrantion";
//     try {
//       final res = await http.post(Uri.parse(resgistration),
//           headers: {"Content-type": "application/json"},
//           body: jsonEncode(user));

//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body.toString());
//         print(data);
//       } else {
//         print("Failed to get the response");
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
