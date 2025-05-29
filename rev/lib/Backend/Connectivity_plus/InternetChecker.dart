import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  static final Connectivity connectivity = Connectivity();

// Check if device has internet connection
  static Future<bool> hasInternetConnection() async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.vpn) ||
        result.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  static Future<bool> hasRealInternetConnection() async {
    try {
      final lookUp = await InternetAddress.lookup('google.com');
      return lookUp.isNotEmpty & lookUp.first.rawAddress.isNotEmpty;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
