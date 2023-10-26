import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/images.dart';
import '../calls.dart';
import '../widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Gap(10.h),
          SizedBox(
            width: double.infinity,
            child: title("PROFILE"),
          ),
          Gap(20.h),
          Gap(28.h),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 45.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("First Name",
                      style: GoogleFonts.jura(
                          textStyle: TextStyle(
                        color: const Color(0xffB64949),
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      )))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
