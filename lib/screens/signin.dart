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
import 'package:nears/configs/const_keys.dart';

import '../configs/colors.dart';
import '../configs/images.dart';
import '../utils/functions.dart';
import '../utils/sharedpref.dart';
import 'widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names

  @override
  void initState() {
   
    phoneNumberController.text = "0276927321";
    passwordController.text = "1234";
    super.initState();
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
                          textFieldPassword(passwordController),
                          Gap(20.h),
                          button("SIGN IN", () async {
                            if (phoneNumberController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              final Map<String, dynamic> loginData = {
                                'phone_number':
                                    phoneNumberController.text.trim(),
                                'password': passwordController.text.trim()
                              };

                              login(loginData).then((value) {
                                if (value["result"] == "success") {
                                  fetchData().then((value) {
                                    if (value["result"] == "success") {
                                      var data = value["message"];
                                      Sharepreference.instance.setBooleanValue(
                                          AppConstKey.signed_in, true);

                                      Sharepreference.instance.setStringValue(
                                          AppConstKey.first_name,
                                          data[AppConstKey.first_name]);
                                      Sharepreference.instance.setStringValue(
                                          AppConstKey.last_name,
                                          data[AppConstKey.last_name]);
                                      Sharepreference.instance.setStringValue(
                                          AppConstKey.date_of_birth,
                                          data[AppConstKey.date_of_birth]);
                                      Sharepreference.instance.setStringValue(
                                          AppConstKey.place_of_residence,
                                          data[AppConstKey.place_of_residence]);
                                      Sharepreference.instance.setStringValue(
                                          AppConstKey.ghana_card_number,
                                          data[AppConstKey.ghana_card_number]);

                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/home", (route) => false);
                                    } else {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        confirmBtnColor: AppColors.ashLight1,
                                        backgroundColor: AppColors.ashLight1,
                                        textTextStyle: GoogleFonts.jura(),
                                        titleTextStyle: GoogleFonts.jura(
                                            textStyle: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold)),
                                        confirmBtnTextStyle: GoogleFonts.jura(
                                            textStyle: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold)),
                                        title: 'Login failed',
                                        text:
                                            'Kindly check your internet connection and try again',
                                        loopAnimation: false,
                                      );
                                    }
                                  });
                                } else if (value["result"] == "error") {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    confirmBtnColor: AppColors.ashLight1,
                                    backgroundColor: AppColors.ashLight1,
                                    textTextStyle: GoogleFonts.jura(),
                                    titleTextStyle: GoogleFonts.jura(
                                        textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold)),
                                    confirmBtnTextStyle: GoogleFonts.jura(
                                        textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold)),
                                    title: 'Login failed',
                                    text: 'Enter Correct Username and Password',
                                    loopAnimation: false,
                                  );
                                }
                              });
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                confirmBtnColor: AppColors.ashLight1,
                                backgroundColor: AppColors.ashLight1,
                                textTextStyle: GoogleFonts.jura(),
                                titleTextStyle: GoogleFonts.jura(
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                                confirmBtnTextStyle: GoogleFonts.jura(
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                                title: 'Oops...',
                                text: 'Enter Username and Password',
                                loopAnimation: false,
                              );
                            }

                            // print(tokens);
                            // Navigator.pushNamed(context, "/home");
                          }),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(97, 255, 255, 255)),
                            ),
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
