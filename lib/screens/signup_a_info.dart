import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:nears/screens/widgets.dart';
import 'package:provider/provider.dart';
import '../configs/images.dart';
import '../utils/app_provider.dart';
import '../utils/functions.dart';

class SignupScreenTwo extends StatefulWidget {
  const SignupScreenTwo({super.key});

  @override
  State<SignupScreenTwo> createState() => _SignupScreenTwoState();
}

class _SignupScreenTwoState extends State<SignupScreenTwo> {
  TextEditingController placeOfResidenceController = TextEditingController();
  TextEditingController ghanaPostGpsController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  @override
  void initState() {
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
                          label("EMail Address"),
                          Gap(10.h),
                          textField(emailAddressController),
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
                          Gap(65.h),
                          button("CONTINUE", () {
                            List<String> fields = [
                              occupationController.text,
                              placeOfResidenceController.text,
                              ghanaPostGpsController.text,
                              emailAddressController.text
                            ];

                            if (hasEmptyFields(fields)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Please complete the form...'),
                              ));
                            } else {
                              Provider.of<AppProvider>(context, listen: false)
                                  .setSignupAInfo(
                                      ghanaPostGps: ghanaPostGpsController.text,
                                      placeOfResidence:
                                          placeOfResidenceController.text,
                                      occupation: occupationController.text,
                                      emailAddress:
                                          emailAddressController.text);

                              Navigator.pushNamed(context, "/signup_3");
                            }
                          }),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "BACK",
                                style: TextStyle(
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
