import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/images.dart';
import '../calls.dart';
import '../widgets.dart';

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
          Gap(28.h),
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
