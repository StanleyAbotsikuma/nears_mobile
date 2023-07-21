import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/screens/widgets.dart';
import '../configs/images.dart';

class SignupScreenTwo extends StatefulWidget {
  const SignupScreenTwo({super.key});

  @override
  State<SignupScreenTwo> createState() => _SignupScreenTwoState();
}

class _SignupScreenTwoState extends State<SignupScreenTwo> {
  TextEditingController placeOfResidenceController = TextEditingController();
  TextEditingController ghanaPostGpsController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

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
                            child: title("ADDITIONAL\n INFORMATION"),
                          ),
                          Gap(30.h),
                          label("PLACE OF BIRTH"),
                          Gap(10.h),
                          textField(dateOfBirthController),
                          Gap(10.h),
                          label("PLACE OF RESIDENCE"),
                          Gap(10.h),
                          textField(placeOfResidenceController),
                          Gap(10.h),
                          label("GHANA POST GPS"),
                          Gap(10.h),
                          textField(ghanaPostGpsController),
                          Gap(10.h),
                          label("OCCUPATION"),
                          Gap(10.h),
                          textField(occupationController),
                          Gap(35.h),
                          button("CONTINUE", () {
                            Navigator.pushNamed(context, "/signup_3");
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
