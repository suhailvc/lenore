import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenore/core/constant.dart';

Widget userInputField(BuildContext context, String assetName, String fieldText,
    String name, TextEditingController controller) {
  var sizeQuery = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: TextStyle(
          fontFamily: 'Jost',
          color: appColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: sizeQuery.height * 0.01),
      Container(
        height: sizeQuery.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(sizeQuery.height * 0.015),
              child: Image.asset(
                assetName,
                width: sizeQuery.width * 0.08,
                height: sizeQuery.height * 0.04,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                inputFormatters: name == "QID/ Passport"
                    ? [LengthLimitingTextInputFormatter(11)]
                    : null,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
                  border: InputBorder.none,
                  hintText: fieldText,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: sizeQuery.height * 0.015,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
// Column userInputField(BuildContext context, String assetName, String fieldText,
//     String name, TextEditingController controller) {
//   var sizeQuery = MediaQuery.of(context).size;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         name,
//         style: TextStyle(
//             fontFamily: 'Jost',
//             color: appColor,
//             fontSize: 14,
//             fontWeight: FontWeight.w400),
//       ),
//       SizedBox(
//         height: sizeQuery.height * 0.01,
//       ),
//       Container(
//         height: sizeQuery.height * 0.07,
//         decoration: BoxDecoration(
//           border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(sizeQuery.height * 0.015),
//               child: Image.asset(
//                 assetName,
//                 width: sizeQuery.width * 0.08,
//                 height: sizeQuery.height * 0.04,
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: controller,
//                 inputFormatters: name == "QID/ Passport"
//                     ? [LengthLimitingTextInputFormatter(11)]
//                     : null,
//                 decoration: InputDecoration(
//                   hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
//                   border: InputBorder.none,
//                   hintText: fieldText,
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: sizeQuery.height * 0.015,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
