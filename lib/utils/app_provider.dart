import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String appStage = "";

// sign up stages
  bool stage1 = false;
  bool stage2 = false;
  bool stage3 = false;
  bool stage4 = false;

// variables
  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';
  String occupation = '';
  String phoneNumber = '';
  String placeOfResidence = '';
  String ghanaPostGps = '';
  String ghanaCardNumber = '';

  void setAppStage({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }

  void setStage1({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }

  void setStage2({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }

  void setStage3({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }

  void setStage4({
    required String appStage,
  }) {
    this.appStage = appStage;

    notifyListeners();
  }

  String getFirstName() => firstName;
  String getLastName() => lastName;
  String getDateOfBirth() => dateOfBirth;
  String getOccupation() => occupation;
  String getPhoneNumber() => phoneNumber;
  String getPlaceOfResidence() => placeOfResidence;
  String getGhanaPostGps() => ghanaPostGps;
  String getGhanaCardNumber() => ghanaCardNumber;
}
