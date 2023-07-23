import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/screens/widgets.dart';

import '../configs/images.dart';
import '../utils/functions.dart';

class SignupScreenOne extends StatefulWidget {
  const SignupScreenOne({super.key});

  @override
  State<SignupScreenOne> createState() => _SignupScreenOneState();
}

class _SignupScreenOneState extends State<SignupScreenOne> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ghanaCardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onFocusChange() {
    setState(() {
      // dateOfBirthController.text = "Hellow";
    });
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                AppAssets.setupBgOpaque,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppAssets.ghFlag,
                            fit: BoxFit.contain,
                            width: 93.w,
                            height: 101.h,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 324.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: title("SIGN UP"),
                          ),
                          Gap(25.h),
                          label("FIRST NAME"),
                          Gap(10.h),
                          textField(firstNameController),
                          Gap(10.h),
                          label("LAST NAME"),
                          Gap(10.h),
                          textField(lastNameController),
                          Gap(10.h),
                          label("DATE OF BIRTH"),
                          Gap(10.h),
                          textField(
                              dateOfBirthController, true, _onFocusChange),
                          Gap(10.h),
                          label("PHONE NUMBER"),
                          Gap(10.h),
                          textField(phoneNumberController),
                          Gap(10.h),
                          label("NATIONAL ID"),
                          Gap(10.h),
                          textField(ghanaCardNumberController),
                          Gap(35.h),
                          button("CONTINUE", () {
                            // List<String> fields = [
                            //   firstNameController.text,
                            //   lastNameController.text,
                            //   dateOfBirthController.text,
                            //   occupationController.text,
                            //   phoneNumberController.text,
                            //   ghanaCardNumberController.text,
                            // ];

                            // if (hasEmptyFields(fields)) {
                            //   // Handle the case where one or more fields are empty or null
                            // } else {
                              
                            // }
                            Navigator.pushNamed(context, "/signup_2");
                          }),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "BACK",
                                style: GoogleFonts.jura(
                                  textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff149A57),
                                    shadows: const [
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 5.0,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
