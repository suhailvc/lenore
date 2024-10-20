// import 'package:flutter/material.dart';
// import 'package:lenore/presentation/screens/gift_by_voucher_screen/gift_by_voucher_screen.dart';

// Container giftVoucherCard(Size querySize, BuildContext context) {
//   return Container(
//     height: querySize.height * 0.18,
//     padding: EdgeInsets.all(querySize.height * 0.02),
//     margin: EdgeInsets.symmetric(horizontal: querySize.height * 0.03),
//     decoration: BoxDecoration(
//       color: const Color(0xFFD6EEEF),
//       borderRadius: BorderRadius.circular(30.0),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.3),
//           spreadRadius: 2,
//           blurRadius: 5,
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Gift By Voucher",
//           style: TextStyle(
//             fontSize: querySize.height * 0.022,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Sitka',
//           ),
//         ),
//         SizedBox(height: querySize.height * 0.02),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 buildVoucherButton("1000 QR", querySize),
//                 SizedBox(width: querySize.width * 0.04),
//                 buildVoucherButton("2000 QR", querySize),
//               ],
//             ),
//             SizedBox(
//               width: querySize.width * 0.004,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const GiftByVoucherScreen(),
//                 ));
//               },
//               child: Text(
//                 "See more ...",
//                 style: TextStyle(
//                   fontFamily: 'Raleway',
//                   fontSize: querySize.height * 0.011,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget buildVoucherButton(String text, Size querySize) {
//   return Container(
//     padding: EdgeInsets.symmetric(
//         vertical: querySize.height * 0.015, horizontal: querySize.width * 0.06),
//     decoration: BoxDecoration(
//       color: const Color(0xFF54A9B1),
//       borderRadius: BorderRadius.circular(20.0),
//     ),
//     child: Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16.0,
//         fontWeight: FontWeight.bold,
//         color: Color(0xFFE7E7E7),
//       ),
//     ),
//   );
// }
