import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/configs/const_keys.dart';
import '../../utils/sharedpref.dart';
import '../widgets.dart';

// ignore: must_be_immutable
class Titles extends StatelessWidget {
  String title;
  String content;
  Titles({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.jura(
                textStyle: TextStyle(
              color: const Color(0xffB64949),
              letterSpacing: .5,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ))),
        Gap(5.h),
        Divider(
          height: 1.h,
        ),
        Gap(8.h),
        Text(content,
            style: GoogleFonts.jura(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              letterSpacing: .5,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ))),
        Gap(20.h),
      ],
    );
  }
}

class SetttingsPage extends StatefulWidget {
  const SetttingsPage({super.key});

  @override
  State<SetttingsPage> createState() => _SetttingsPageState();
}

class _SetttingsPageState extends State<SetttingsPage> {
  String _firstName = "";
  String _lastName = "";
  String _dob = "";
  String _place = "";
  String _ghanaCardIn = "";
  void loadProfile() async {
    _firstName = await Sharepreference.instance
        .getStringValue(AppConstKey.first_name)
        .then((value) => value);
    _lastName = await Sharepreference.instance
        .getStringValue(AppConstKey.last_name)
        .then((value) => value);
    _dob = await Sharepreference.instance
        .getStringValue(AppConstKey.date_of_birth)
        .then((value) => value);

    _place = await Sharepreference.instance
        .getStringValue(AppConstKey.place_of_residence)
        .then((value) => value);

    _ghanaCardIn = await Sharepreference.instance
        .getStringValue(AppConstKey.ghana_card_number)
        .then((value) => value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

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
                  Titles(title: "FIRST NAME", content: _firstName),
                  Titles(title: "LAST NAME", content: _lastName),
                  Titles(title: "DATE OF BIRTH", content: _dob),
                  Titles(title: "PLACE OF RESIDENCE", content: _place),
                  Titles(title: "GHANA CARD ID-NUMBER", content: _ghanaCardIn),
                  Gap(60.h),
                  button1("SIGN OUT", () async {
                    Sharepreference.instance.removeAll();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
