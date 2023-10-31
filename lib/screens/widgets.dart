import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nears/configs/colors.dart';
import '../configs/images.dart';

Text title(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Jura',
      color: Colors.black,
      letterSpacing: .5,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      shadows: const [
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 4.0,
          color: Color.fromARGB(115, 0, 0, 0),
        )
      ],
    ),
  );
}

Text title2(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'Jura',
        color: Colors.black,
        letterSpacing: .5,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        shadows: const [
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 4.0,
            color: Color.fromARGB(115, 0, 0, 0),
          )
        ],
      ),
    
  );
}

Text label(String name) {
  return Text(
    name,
    style:  TextStyle(
        fontFamily: 'Jura',
        color: AppColors.whine,
        letterSpacing: .5,
        fontWeight: FontWeight.w700,
        fontSize: 17.sp,
        shadows: const [
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            color: Colors.white,
          )
        ],
      ),
    
    textAlign: TextAlign.left,
  );
}

Container textField(TextEditingController controller,
    [bool date = false, final onFocusChange]) {
  return Container(
    width: double.infinity,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: AppColors.ashLight,
      border: Border.all(
        color: const Color.fromARGB(255, 147, 147, 147),
        width: 1.0,
      ),
    ),
    child: TextField(
      style: TextStyle(fontSize: 16.sp),
      controller: controller,
      readOnly: date,
      onTap: date ? onFocusChange : null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );
}

Container textFieldPassword(TextEditingController controller,
    [bool date = false, final onFocusChange]) {
  return Container(
    width: double.infinity,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: AppColors.ashLight,
      border: Border.all(
        color: const Color.fromARGB(255, 147, 147, 147),
        width: 1.0,
      ),
    ),
    child: TextField(
      obscureText: true,
      style: TextStyle(fontSize: 16.sp),
      controller: controller,
      readOnly: date,
      onTap: date ? onFocusChange : null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );
}

Container button(String name, final callback) {
  return Container(
    width: double.infinity,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: AppColors.green,
    ),
    child: MaterialButton(
      onPressed: callback,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      child: Text(
        name,
        style: const TextStyle(fontFamily: 'Jura', fontWeight: FontWeight.w700),
      ),
    ),
  );
}

Container button1(String name, final callback) {
  return Container(
    width: double.infinity,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: const Color.fromARGB(218, 244, 49, 49),
    ),
    child: MaterialButton(
      onPressed: callback,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      child: Text(
        name,
        style: const TextStyle(fontFamily: 'Jura', fontWeight: FontWeight.w700),
      ),
    ),
  );
}

// ignore: must_be_immutable
class VerifyButton extends StatefulWidget {
  String name;
  // ignore: prefer_typing_uninitialized_variables
  final callback;
  VerifyButton(this.name, this.callback, {super.key});

  @override
  State<VerifyButton> createState() => _VerifyButtonState();
}

class _VerifyButtonState extends State<VerifyButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 230.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.ashLight,
              borderRadius: BorderRadius.circular(25.h),
            ),
            child: Center(
              child: Text(widget.name,
                  softWrap: true,
                  style: const TextStyle(
                      fontFamily: 'Jura',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(187, 19, 19, 19))),
            ),
          ),
          Container(
            width: 67.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(25.h),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.missingIcon,
              ),
            ),
          )
        ],
      ),
    );
  }
}
