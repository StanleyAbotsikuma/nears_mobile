import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nears/configs/images.dart';
import '../configs/const_keys.dart';
import '../utils/functions.dart';
import '../utils/sharedpref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  bool _signin = false;

  void check_sign_in_status() async {
    Sharepreference.instance.containsKey(AppConstKey.signed_in).then((value) {
      if (value) {
        Sharepreference.instance
            .getBooleanValue(AppConstKey.signed_in)
            .then((value) {
          if (value) {
            _signin = true;
          } else {}
        });
      } else {}
    });
  }

  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  void doesValueExist() async {
    final value = await secureStorage.read(key: "endpoint");

    if (value == null) {
      Dio dio = Dio();
      try {
        final response = await dio.get(
            'https://raw.githubusercontent.com/StanleyAbotsikuma/raw_files/main/endpoints.json');
        if (response.statusCode == 200) {
          final data = jsonDecode(response.data);
          print(data["protocolType"]);
          print(data["host"]);
          print(data["wsType"]);
          await secureStorage.write(
              key: "protocolType", value: data["protocolType"]);
          await secureStorage.write(key: "host", value: data["host"]);
          await secureStorage.write(key: "wsType", value: data["wsType"]);

          await secureStorage.write(key: "endpoint", value: "true");
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    doesValueExist();
    loadMessages(context).then((value) => Null);
    super.initState();
    check_sign_in_status();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _visible = true;
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _visible = false;
      });
      _signin
          ? Navigator.pushNamedAndRemoveUntil(
              context, "/home", (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, "/signin", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Container(
          height: 249.w,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.1,
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                AppAssets.nearLogo,
                width: 150.w,
                height: 150.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
