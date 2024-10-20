// import 'package:flutter/material.dart';

// Container customCategoriesCard(
//     Color colorName,
//     Size querySize,
//     String cardName,
//     String firstCategoryname,
//     String firstCategoryImage,
//     String secondCategoryName,
//     String secondCategoryImage,
//     String thirdCategoryname,
//     String thirdCategoryImage,
//     String fourthCategoryName,
//     String fourthCategoryImage) {
//   return Container(
//     //height: querySize.height * 0.23,
//     height: querySize.height * 0.219,
//     padding: EdgeInsets.all(querySize.height * 0.02),
//     margin: EdgeInsets.symmetric(horizontal: querySize.height * 0.03),
//     decoration: BoxDecoration(
//       color: colorName,
//       borderRadius: BorderRadius.circular(30.0),
//       // boxShadow: [
//       //   BoxShadow(
//       //     color: Colors.grey.withOpacity(0.3),
//       //     spreadRadius: 2,
//       //     blurRadius: 5,
//       //   ),
//       // ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: querySize.height * 0.01),
//         Text(
//           cardName,
//           style: TextStyle(
//               fontSize: querySize.height * 0.022,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Sitka'),
//         ),
//         SizedBox(height: querySize.height * 0.02),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             buildCategoryItem(
//               firstCategoryImage,
//               firstCategoryname,
//               querySize,
//             ),
//             buildCategoryItem(
//               secondCategoryImage,
//               secondCategoryName,
//               querySize,
//             ),
//             buildCategoryItem(
//               thirdCategoryImage,
//               thirdCategoryname,
//               querySize,
//             ),
//             buildCategoryItem(
//               fourthCategoryImage,
//               fourthCategoryName,
//               querySize,
//             ),
//           ],
//         ),
//         SizedBox(height: querySize.height * 0.01),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             "See more ...",
//             style: TextStyle(
//               fontFamily: 'Raleway',
//               fontSize: querySize.height * 0.011,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget buildCategoryItem(String imagePath, String title, Size querySize) {
//   return Column(
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(15.0),
//         child: Image.asset(
//           imagePath,
//           width: querySize.width * 0.16,
//           height: querySize.width * 0.13,
//           fit: BoxFit.cover,
//         ),
//       ),
//       // Container(
//       //   width: querySize.width * 0.17,
//       //   height: querySize.width * 0.15,
//       //   decoration: BoxDecoration(
//       //     color: Colors.white,
//       //     borderRadius: BorderRadius.circular(15.0),
//       //     image: DecorationImage(
//       //       image: AssetImage(imagePath),
//       //       fit: BoxFit.cover,
//       //     ),
//       //   ),
//       // ),
//       SizedBox(height: querySize.height * 0.01),
//       Text(
//         title,
//         style: TextStyle(
//           fontSize: querySize.height * 0.012,
//           fontFamily: 'Segoe',
//           fontWeight: FontWeight.w500,
//           color: Colors.black,
//         ),
//       ),
//     ],
//   );
// }
