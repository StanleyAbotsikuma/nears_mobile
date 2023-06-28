import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String appStage = "";

  void setAppStage({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }
}
