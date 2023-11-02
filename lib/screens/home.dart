// ignore_for_file: void_checks

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nears/configs/colors.dart';
import 'package:nears/screens/widgets.dart';
import 'package:provider/provider.dart';
import '../configs/images.dart';
import '../utils/app_provider.dart';
import '../utils/functions.dart';
import 'pages/homepage.dart';
import 'pages/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int menuSelect = 0;
  void updateUserLocation() {
    final getlocation = getCurrentLocation();
    getlocation.then((Position position) {
      double latitude = position.latitude;
      double longitude = position.longitude;
      Provider.of<AppProvider>(context, listen: false)
          .setCurrentLocation(longitude: longitude, latitude: latitude);
      getAddress(lat: latitude, lon: longitude).then((value) {
        if (value['result'] == "success") {
          var data = value["message"];
          Provider.of<AppProvider>(context, listen: false)
              .setCurrentAddress(location: data["display_name"]);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${data["display_name"]}'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error Location update'),
          ));
        }
      });

      setState(() {});
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error Location update'),
      ));
    });
  }

  @override
  void initState() {
    super.initState();

    try {
      updateUserLocation();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.zero,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppAssets.ghFlag,
                            fit: BoxFit.contain,
                            width: 93.w,
                            height: 101.h,
                          ),
                          CircleAvatar(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              child: Padding(
                                padding: EdgeInsets.all(15.w),
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.contain,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      // width: 324.w,
                      height: MediaQuery.of(context).size.height - 160.h,
                      child: Column(
                        children: [
                          menuSelect == 0
                              ? const HomePage()
                              : menuSelect == 4
                                  ? const SetttingsPage()
                                  : Expanded(
                                      child: Container(
                                        // color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            title2("Page Under Construction"),
                                            const Icon(
                                                Icons.construction_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                          // Gap(40.h),
                          Container(
                            width: 376.w,
                            height: 62.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(5, 0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(68),
                              color: AppColors.ashLight,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // ignore: void_checks
                                MenuButtons(AppAssets.homeIcon, () {
                                  setState(() {
                                    menuSelect = 0;
                                  });
                                }),
                                // ignore: void_checks
                                MenuButtons(AppAssets.followIcon, () {
                                  setState(() {
                                    menuSelect = 1;
                                  });
                                }),
                                MenuButtons(AppAssets.tipIcon, () {
                                  setState(() {
                                    menuSelect = 2;
                                  });
                                }),
                                MenuButtons(AppAssets.historyIcon, () {
                                  setState(() {
                                    menuSelect = 3;
                                  });
                                }),
                                MenuButtons(AppAssets.settingsIcon, () {
                                  setState(() {
                                    menuSelect = 4;
                                  });
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MenuButtons extends StatefulWidget {
  String icon;
  final callback;
  MenuButtons(this.icon, void this.callback, {super.key});

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.callback,
      child: SvgPicture.asset(
        widget.icon,
        width: 22.w,
        height: 22.h,
      ),
    );
  }
}
