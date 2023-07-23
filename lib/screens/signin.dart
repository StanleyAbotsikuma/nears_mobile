// String userId = userIdController.text;
// String firstName = firstNameController.text;
// String lastName = lastNameController.text;
// String dateOfBirth = dateOfBirthController.text;
// String occupation = occupationController.text;
// String phoneNumber = phoneNumberController.text;
// String accountId = accountIdController.text;
// String placeOfResidence = placeOfResidenceController.text;
// String ghanaPostGps = ghanaPostGpsController.text;
// String ghanaCardNumber = ghanaCardNumberController.text;

// File ghanaCardPicture;
// File photo;

// String ghanaCardPicturePath = ghanaCardPicture?.path;
// String photoPath = photo?.path;
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/images.dart';
import '../utils/functions.dart';
import 'widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                AppAssets.setupBg,
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
                          Gap(10.h),
                          SizedBox(
                            width: double.infinity,
                            child: title("SIGN IN"),
                          ),
                          Gap(15.h),
                          label("PHONE"),
                          Gap(10.h),
                          textField(phoneNumberController),
                          Gap(10.h),
                          label("PASSWORD"),
                          Gap(10.h),
                          textField(passwordController),
                          Gap(20.h),
                          button("SIGN IN", () async {
                            if (phoneNumberController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              final Map<String, dynamic> loginData = {
                                'phone_number':
                                    phoneNumberController.text.trim(),
                                'password': passwordController.text.trim()
                              };

                              final tokens = await login(loginData);
                              final data = await fetchData();
                              print(data);
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'Oops...',
                                text: 'Enter Username and Password',
                                loopAnimation: false,
                              );
                            }

                            // print(tokens);
                            // Navigator.pushNamed(context, "/home");
                          }),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup_1");
                            },
                            child: Center(
                              child: Wrap(
                                children: [
                                  Text(
                                    "Do have an account?",
                                    style: GoogleFonts.jura(
                                      textStyle: TextStyle(
                                        letterSpacing: .5,
                                        fontSize: 17.sp,
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
                                  Text(
                                    " Sign-Up",
                                    style: GoogleFonts.jura(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5,
                                        fontSize: 17.sp,
                                        color: const Color(0xff294E3B),
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
                                  )
                                ],
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
