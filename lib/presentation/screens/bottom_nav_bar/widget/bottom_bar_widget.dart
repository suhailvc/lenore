import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget symbol({
  required String name,
  required String logo,
  required Size querySize,
  required Color colorCode,
  Color? textColor,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SvgPicture.asset(
        logo,
        width: querySize.width * 0.07,
        height: querySize.width * 0.07,
        color: colorCode,
      ),
      // Image.asset(
      //   color: colorCode,
      //   logo,
      //   width: querySize.width * 0.07,
      //   height: querySize.width * 0.07,
      // ),
      Text(
        name,
        style: TextStyle(
          fontFamily: 'Segoe',
          fontSize: querySize.height * 0.013,
          color: textColor,
        ),
      ),
      // Stack(
      //   alignment: Alignment.center, // Centers everything within the Stack
      //   children: [
      //     Image.asset(
      //       "assets/images/bottom_nav1/circle.png", // Path to your circular PNG image
      //       width:
      //           querySize.width * 0.15, // Adjust the size to match your design
      //       height:
      //           querySize.width * 0.15, // Adjust the size to match your design
      //     ),
      //     Positioned(
      //       top: 10,
      //       child: Image.asset(
      //         color: Colors.white, logo!, // Path to your logo image
      //         width: querySize.width * 0.048, // Adjust size as needed
      //         height: querySize.width * 0.048,
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 12, // Adjust this value to position the text below the logo
      //       child: Text(
      //         name!,
      //         style: const TextStyle(
      //           fontSize: 7, // Adjust font size as needed

      //           color: Colors.white, // Adjust text color as needed
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ],
  );
}
