import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:nears/configs/images.dart';
import 'widgets.dart';

class SignupScreenVerify extends StatefulWidget {
  const SignupScreenVerify({super.key});

  @override
  State<SignupScreenVerify> createState() => _SignupScreenVerifyState();
}

class _SignupScreenVerifyState extends State<SignupScreenVerify> {
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
                            child: title("ACCOUNT \n VERIFICATION"),
                          ),
                          Gap(40.h),
                          VerifyButton("Upload Profile Picture", () {}),
                          VerifyButton("Upload Ghana Card", () {}),
                          VerifyButton("Verify Phone Number", () {}),
                          Gap(35.h),
                          button("CONTINUE", () {
                            Navigator.pushNamed(context, "/signup_4");
                          }),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "BACK",
                                style: TextStyle(
                                  fontFamily: 'Jura',
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
