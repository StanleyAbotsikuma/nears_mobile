import 'package:flutter/material.dart';
import 'package:nears/screens/signin.dart';
import 'package:nears/screens/signup_info.dart';

import '../screens/signup_a_info.dart';

class GenerateRoute {
  //onGenerateRoute init
  static Route? onGenerateRoute(RouteSettings settings) {
    //pagePath
    String? pagePath = settings.name;

    switch (pagePath) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SignupScreenTwo());
      // case "/":
      //         return MaterialPageRoute(builder: (_) => const SigninScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SignupScreenTwo());
    }
  }
}
