import 'package:flutter/material.dart';

import '../tests/login.dart';

class GenerateRoute {
  //onGenerateRoute init
  static Route? onGenerateRoute(RouteSettings settings) {
    //pagePath
    String? pagePath = settings.name;

    switch (pagePath) {
      case "/":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
