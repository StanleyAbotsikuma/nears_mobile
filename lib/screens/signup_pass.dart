// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/utils/app_provider.dart';
import 'package:provider/provider.dart';
import '../configs/images.dart';
import '../utils/functions.dart';
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
                          Gap(45.h),
                          button("COMPLETE", () async {
                            if (passwordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty &&
                                confirmPasswordController.text ==
                                    passwordController.text) {
                              final deviceInfoPlugin = DeviceInfoPlugin();
                              final deviceInfo =
                                  await deviceInfoPlugin.deviceInfo;
                              final allInfo = deviceInfo.data;
                              final deviceID = allInfo['serialNumber'];
                              final Map<String, dynamic> createAccountData = {
                                "email": Provider.of<AppProvider>(context,
                                        listen: false)
                                    .getEmailAddress(),
                                'phone_number': Provider.of<AppProvider>(
                                        context,
                                        listen: false)
                                    .getPhoneNumber(),
                                "device_id": deviceID,
                                'password': passwordController.text.trim()
                              };

                              final Future<Map<String, dynamic>> a =
                                  createAccount(createAccountData);
                              Map<String, dynamic> accountData = await a;
                              dynamic results = accountData["results"];
                              if (results == "success") {
                                final Map<String, dynamic> createUserData = {
                                  "first_name": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getFirstName(),
                                  "last_name": Provider.of<AppProvider>(context,
                                          listen: false)
                                      .getLastName(),
                                  "date_of_birth": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getDateOfBirth(),
                                  "occupation": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getOccupation(),
                                  "phone_number": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getPhoneNumber(),
                                  "ghana_post_gps": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getGhanaPostGps(),
                                  "place_of_residence":
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getPlaceOfResidence(),
                                  "ghana_card_number": Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                      .getGhanaCardNumber()
                                };
                                createUser(createUserData);
                              }
                            }
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
