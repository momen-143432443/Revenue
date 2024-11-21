import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Front/SignPages/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyA5TIyMbfdza19CZwJ_IZqnUlIxWiugrTo',
    appId: "1:220839691149:android:be4dbceb416eb8654d73c4",
    messagingSenderId: '220839691149',
    projectId: 'csswaps-36427',
    storageBucket: "csswaps-36427.firebasestorage.app",
  ));
  await Firebase.initializeApp().then((value) => Get.put(AuthenticationRepo()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
