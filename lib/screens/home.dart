import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/screens/widgets.dart';

import '../configs/images.dart';
import 'pages/homepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool check = true;
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
                          check
                              ? const HomePage()
                              : Expanded(
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                          // Gap(40.h),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check = !check;
                              });
                            },
                            child: Container(
                              width: 376.w,
                              height: 62.h,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(68),
                                color: const Color(0xffd9d9d9),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MenuButtons(AppAssets.homeIcon),
                                  MenuButtons(AppAssets.followIcon),
                                  MenuButtons(AppAssets.tipIcon),
                                  MenuButtons(AppAssets.historyIcon),
                                  MenuButtons(AppAssets.settingsIcon),
                                ],
                              ),
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
  MenuButtons(this.icon, {super.key});

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: SvgPicture.asset(
        widget.icon,
        width: 22.w,
        height: 22.h,
      ),
    );
  }
}
