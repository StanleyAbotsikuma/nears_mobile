import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nears/configs/colors.dart';
import '../configs/images.dart';

Text title(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: GoogleFonts.jura(
      textStyle: TextStyle(
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
    ),
  );
}

Text label(String name) {
  return Text(
    name,
    style: GoogleFonts.jura(
      textStyle: TextStyle(
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
        style: GoogleFonts.jura(fontWeight: FontWeight.w700),
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
                  style: GoogleFonts.jura(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(187, 19, 19, 19))),
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



// Stack(children: [    Stack(children: [    Image.asset(
//                             "assets/Ellipse 1.png",
//                             width: 168,
//                             height: 168,
//                             ),
//                 Image.asset(
//                             "assets/Ellipse 3.png",
//                             width: 142.79998779296875,
//                             height: 142.8000030517578,
//                             ),
//                 Image.asset(
//                             "assets/Ellipse 2.png",
//                             width: 117.60000610351562,
//                             height: 117.5999984741211,
//                             )],),
//         Container(
//                 width: 69.33331298828125,
//                 height: 52,
//                 )],)




// Text(
//             "Press and hold for 4 seconds",
//             style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeith.w700,
//             )
//         )



// Text(
//             "The misuse of arms is a danger to our peace 
// and security. Say "No" to illicit arms in Ghana.
// See Something, Say Something.
// Be Vigilant Call 999",
//             style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeith.w700,
//             )
//         )
