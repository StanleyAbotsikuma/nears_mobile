import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              width: 324,
              height: 51,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Color(0xff149a57),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Text('Button'),
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
            ),
            Container(
              width: 324,
              height: 51,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Color(0xfff2f2f2),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
