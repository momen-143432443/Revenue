import 'package:css/Backend/Connectivity_plus/InternetChecker.dart';
import 'package:flutter/material.dart';

class SafeTap {
  static Future<void> execute({
    required BuildContext context,
    required Future<void> Function() onTap,
    VoidCallback? noConnect,
  }) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    try {
      final hasConnect = await InternetChecker.hasRealInternetConnection();
      if (hasConnect) {
        await onTap();
      } else {
        if (noConnect != null) {
          noConnect();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Kindly Reconnect Your Internet")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
