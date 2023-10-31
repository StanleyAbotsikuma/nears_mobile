import 'package:flutter/material.dart';
import 'package:nears/screens/calls.dart';
import 'package:nears/screens/signin.dart';
import 'package:nears/screens/signup_info.dart';
import 'package:nears/screens/signup_pass.dart';

import '../screens/home.dart';
import '../screens/signup_a_info.dart';
import '../screens/signup_verify.dart';
import '../screens/splash_screen.dart';
import '../tests/login.dart';

class GenerateRoute {
  //onGenerateRoute init
  static Route? onGenerateRoute(RouteSettings settings) {
    //pagePath
    String? pagePath = settings.name;

    switch (pagePath) {
      // case "/":
      //   return MaterialPageRoute(builder: (_) => AudioPlayerWidget());
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/signin":
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case "/signup_1":
        return MaterialPageRoute(builder: (_) => const SignupScreenOne());
      case "/signup_2":
        return MaterialPageRoute(builder: (_) => const SignupScreenTwo());
      case "/signup_3":
        return MaterialPageRoute(builder: (_) => const SignupScreenVerify());
      case "/signup_4":
        return MaterialPageRoute(builder: (_) => const SignupScreenPassword());
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
    }
  }
}
