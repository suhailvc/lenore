import 'package:flutter/material.dart';

Widget weightAndPurityButton({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  String? errorText,
}) {
  final Size querySize = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: querySize.width * 0.25,
        height: querySize.height * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xffEFEEEE),
          borderRadius: BorderRadius.circular(querySize.width * 0.03),
        ),
        child: TextField(
          // Changed from TextFormField to TextField
          controller: controller,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: querySize.width * 0.035,
              fontWeight: FontWeight.w600,
              fontFamily: 'Segoe',
              color: const Color(0xFF8C8C8C),
            ),
            border: InputBorder.none,
            isCollapsed: true, // Add this to remove internal padding
            contentPadding: EdgeInsets.symmetric(
              vertical: querySize.height * 0.015, // Increased padding
              horizontal: 0,
            ),
          ),
          style: TextStyle(
            fontSize: querySize.width * 0.038,
            fontWeight: FontWeight.w600,
            fontFamily: 'Segoe',
            color: const Color(0xFF8C8C8C),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
      if (errorText != null && errorText.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: querySize.width * 0.03,
            ),
          ),
        ),
    ],
  );
}
/// A reusable custom input container with a centered TextFormField and optional error text.
// Widget weightAndPurityButton({
//   required BuildContext context,
//   required String hintText,
//   required TextEditingController controller,
//   String? errorText, // Accepts nullable String for error text
// }) {
//   final Size querySize =
//       MediaQuery.of(context).size; // Access querySize directly in the function

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         width: querySize.width * 0.25,
//         height: querySize.height * 0.05,
//         decoration: BoxDecoration(
//           color: const Color(0xffEFEEEE),
//           borderRadius: BorderRadius.circular(querySize.width * 0.03),
//         ),
//         child: Center(
//           child: TextFormField(
//             controller: controller,
//             textAlign:
//                 TextAlign.center, // Center-align the input text and hint text
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 fontSize: querySize.width * 0.038,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Segoe',
//                 color: const Color(0xFF8C8C8C),
//               ),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(
//                 vertical: querySize.height * 0.008,
//               ),
//             ),
//             style: TextStyle(
//               fontSize: querySize.width * 0.038,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Segoe',
//               color: const Color(0xFF8C8C8C),
//             ),
//             keyboardType:
//                 TextInputType.number, // Optional: restrict input to numbers
//           ),
//         ),
//       ),

//       // Display error text if available
//       if (errorText != null && errorText.isNotEmpty)
//         Padding(
//           padding: EdgeInsets.only(top: 4),
//           child: Text(
//             errorText,
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: querySize.width * 0.03,
//             ),
//           ),
//         ),
//     ],
//   );
// }
