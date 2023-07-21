import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/images.dart';
import 'widgets.dart';

class SignupScreenPassword extends StatefulWidget {
  const SignupScreenPassword({super.key});

  @override
  State<SignupScreenPassword> createState() => _SignupScreenPasswordState();
}

class _SignupScreenPasswordState extends State<SignupScreenPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                            child: title("SET ACCOUNT \n PASSWORD"),
                          ),
                          Gap(40.h),
                          label("ENTER PASSWORD"),
                          Gap(10.h),
                          textField(passwordController),
                          Gap(10.h),
                          label("CONFIRM PASSWORD"),
                          Gap(10.h),
                          textField(confirmPasswordController),
                          Gap(35.h),
                          button("COMPLETE", () {
                            Navigator.pushNamed(context, "/home");
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
