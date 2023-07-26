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
  String emailAddress = '';

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
  String getEmailAddress() => emailAddress;

  void setSignupInfo(
      {required String firstName,
      required String lastName,
      required String dateOfBirth,
      required String ghanaCardNumber,
      required String phoneNumber}) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.dateOfBirth = dateOfBirth;
    this.ghanaCardNumber = ghanaCardNumber;
    this.phoneNumber = phoneNumber;
    stage1 = true;
    notifyListeners();
  }

  void setSignupAInfo(
      {required String ghanaPostGps,
      required String placeOfResidence,
      required String occupation,
      required String emailAddress}) {
    this.occupation = occupation;
    this.placeOfResidence = placeOfResidence;
    this.ghanaPostGps = ghanaPostGps;
    this.emailAddress = emailAddress;
    stage2 = true;
    notifyListeners();
  }
}
