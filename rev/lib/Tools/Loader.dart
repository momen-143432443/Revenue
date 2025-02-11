import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader {
  static void startLoading() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => PopScope(
          canPop: false,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Center(
                child: LoadingAnimationWidget.inkDrop(color: lime, size: 45)),
          )),
    );
  }

  static void stopLaoding() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
