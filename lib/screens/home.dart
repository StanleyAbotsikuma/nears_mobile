import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nears/configs/colors.dart';
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

          CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            confirmBtnColor: AppColors.ashLight1,
            backgroundColor: AppColors.ashLight1,
            textTextStyle: const TextStyle(fontFamily: 'Jura'),
            titleTextStyle: TextStyle(
                fontFamily: 'Jura',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            confirmBtnTextStyle: TextStyle(
                fontFamily: 'Jura',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            title: 'Current Location Updated',
            text: "Address: ${data["display_name"]}",
            loopAnimation: false,
          );
        } else {
          CoolAlert.show(
            confirmBtnColor: AppColors.ashLight1,
            backgroundColor: AppColors.ashLight1,
            textTextStyle: const TextStyle(fontFamily: 'Jura'),
            titleTextStyle: TextStyle(
                fontFamily: 'Jura',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            confirmBtnTextStyle: TextStyle(
                fontFamily: 'Jura',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            context: context,
            type: CoolAlertType.error,
            title: 'Location Update Error ',
            text: "Kindly Enable your GPS Services",
            loopAnimation: false,
          );
        }
      });

      setState(() {});
    }).catchError((e) {
      CoolAlert.show(
        confirmBtnColor: AppColors.ashLight1,
        backgroundColor: AppColors.ashLight1,
        textTextStyle: const TextStyle(fontFamily: 'Jura'),
        titleTextStyle: TextStyle(
            fontFamily: 'Jura', fontSize: 18.sp, fontWeight: FontWeight.bold),
        confirmBtnTextStyle: TextStyle(
            fontFamily: 'Jura', fontSize: 18.sp, fontWeight: FontWeight.bold),
        context: context,
        type: CoolAlertType.error,
        title: 'Location Update Error ',
        text: "Kindly Enable your GPS Services",
        loopAnimation: false,
      );
    });
  }

  // final MessagesDatabaseProvider _messagesDatabaseProvider =
  //     MessagesDatabaseProvider();
  @override
  void initState() {
    super.initState();
    // _messagesDatabaseProvider.initDB();
    // _messagesDatabaseProvider.addMessage(Messages(
    //     id: "65-52",
    //     name: "John Doe",
    //     message:
    //         "HThe misuse of arms is a danger to our peace and security. Say 'No' to illicit arms in Ghana.See Something, Say Something.Be Vigilant Call 999",
    //     date: "2023-10-26T09:30:00Z",
    //     sender: "Jane Smith",
    //     level: 2,
    //     view: true));
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
                                        color: Colors.yellow,
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
                                MenuButtons(AppAssets.homeIcon, () {
                                  setState(() {
                                    menuSelect = 0;
                                  });
                                }),
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
