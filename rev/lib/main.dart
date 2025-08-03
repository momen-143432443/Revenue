import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Controllers/ForNotificationContorller/NotificationController.dart';
import 'package:css/Front/GeneralPages/OffersPage.dart';
import 'package:css/Front/SplashScreen/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyA5TIyMbfdza19CZwJ_IZqnUlIxWiugrTo',
    appId: "1:220839691149:android:be4dbceb416eb8654d73c4",
    messagingSenderId: '220839691149',
    projectId: 'csswaps-36427',
    storageBucket: "csswaps-36427.firebasestorage.app",
  ));
  Get.put(NotificationController());
  await Firebase.initializeApp().then((value) => Get.put(AuthenticationRepo()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/Offers': (context) => const OffersPage(),
      },
      debugShowCheckedModeBanner: false,

      // Required to fix the MaterialLocalizations error
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Add your supported locales here
      ],
      home: const SplashScreen(),
    );
  }
}
