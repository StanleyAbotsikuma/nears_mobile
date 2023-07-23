import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/screens/widgets.dart';

import '../configs/images.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Gap(10.h),
          SizedBox(
            width: double.infinity,
            child: title("ARE YOU IN AN \n EMERGENCY?"),
          ),
          Gap(20.h),
          Text("Press and hold for 4 seconds",
              style: GoogleFonts.jura(
                  textStyle: TextStyle(
                color: const Color(0xffB64949),
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ))),
          Gap(28.h),
          Container(
            width: 155.h,
            height: 155.w,
            padding: EdgeInsets.all(15.h),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffb64949),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: MaterialButton(
              onPressed: () {},
              color: const Color(0xffa81717),
              shape: const CircleBorder(),
              child: SvgPicture.asset(
                AppAssets.alertIcon,
                width: 69.33.w,
                height: 52.h,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 25.h, right: 10.w, left: 10.w),
              decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(25)),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: 348.w,
                        height: 76.h,
                        margin: EdgeInsets.all(10.w),
                        padding: EdgeInsets.only(left: 20.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: const Color(0x424cffc9)),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "The misuse of arms is a danger to our peace and security. Say 'No' to illicit arms in Ghana.See Something, Say Something.Be Vigilant Call 999",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: SvgPicture.asset(
                                AppAssets.closeIcon,
                                width: 14.w,
                                height: 14.h,
                              ),
                            ),
                          ],
                        ));
                  }),
            ),
          ),
        ],
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
