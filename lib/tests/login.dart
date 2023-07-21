import 'package:flutter/material.dart';
import 'package:nears/configs/images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.ghFlag,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    )
        //   Stack(
        // children: [
        //   SizedBox(
        //     child: Image.asset(
        //       'assets/images/setup_bg.png',
        //       fit: BoxFit.cover,
        //       width: 324,
        //       height: 51,
        //     ),
        //   ),
        //   Column(
        //     children: [
        // Container(
        //   width: 324,
        //   height: 51,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(45),
        //     color: Color(0xff149a57),
        //   ),
        //   child: MaterialButton(
        //     onPressed: () {},
        //     child: Text('Button'),
        //     textColor: Colors.white,
        //     padding: EdgeInsets.symmetric(vertical: 12),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(45),
        //     ),
        //   ),
        // ),
        //       Container(
        //         width: 324,
        //         height: 51,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(45),
        //           color: Color(0xfff2f2f2),
        //         ),
        //         child: TextField(
        //           decoration: InputDecoration(
        //             border: InputBorder.none,
        //             contentPadding: EdgeInsets.symmetric(horizontal: 16),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
        //   )
        );
  }
}
