// input field

// label

// title

// button

// icon

// page text

import 'package:flutter/material.dart';

Text label() {
  return Text(
    "NATIONAL ID",
    style: TextStyle(
        fontFamily: "Jura",
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color(0xff9b0505)),
    textAlign: TextAlign.center,
  );
}
// style: GoogleFonts.lato(),

Widget textbox() {
  return Container(
      width: 324,
      height: 51,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45), color: Color(0xfff2f2f2)));
}

Widget button() {
  return Container(
      width: 324,
      height: 51,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45), color: Color(0xff149a57)));
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




// signup color 294E3B

// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 324,
//       height: 51,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(45),
//         color: Color(0xff149a57),
//       ),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Text('Button'),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.transparent,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(45),
//           ),
//         ),
//       ),
//     );
//   }
// }



// Container(
//   width: 324,
//   height: 51,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(45),
//     color: Color(0xfff2f2f2),
//   ),
//   child: TextField(
//     decoration: InputDecoration(
//       border: InputBorder.none,
//       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//     ),
//   ),
// ),