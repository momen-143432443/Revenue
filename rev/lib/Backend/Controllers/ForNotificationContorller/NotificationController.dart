import 'dart:convert';
import 'package:css/Tools/Alerts.dart';
import 'package:css/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get intance => Get.find();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  Alerts alerts = Alerts();

  Future<void> initializeFCM(BuildContext context) async {
    final noti = '${base64Url}SendNotification';
    await messaging.requestPermission();
    // Get FCM Token and send it to backend (Node.js)
    final token = await messaging.getToken();
    print('📱 FCM Token: $token');
    // TODO: send token to Node.js backend via HTTP

    // Foreground notifications
    /*  FirebaseMessaging.onMessage.listen(
      (RemoteMessage remote) {
        if (remote.notification != null) {
          final context = navigatorKey.currentContext;
          print("📢 Foreground notification: ${remote.notification!.title}");
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (context != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(remote.notification?.title ?? 'Title'),
                    content: Text(remote.notification?.body ?? 'Body'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
 */
    //Tapped from background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        final screen = message.data['screen'];
        if (screen == 'OffersPage') {
          Navigator.pushNamed(context, '/Offers');
          print("📢 Foreground notification: ${message.notification!.title}");
        }
      },
    );
    // 🟢 Tapped from terminated state
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage?.data['screen'] == 'OffersPage') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/Offers');
      });
    }
  }

  void showNotiDialog(Map<String, dynamic> data) {
    final context = navigatorKey.currentContext;
    final screen = data['screen'];
    if (context == null) return;
    if (screen == 'Offers') {
      Navigator.pushNamedAndRemoveUntil(context, '/Offers', (route) => false);
    }
  }
}
