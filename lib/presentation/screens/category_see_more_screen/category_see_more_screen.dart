// import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/category_see_more_screen/widget/category_see_more_card.dart';
// import 'package:lenore/presentation/screens/category_see_more_screen/widget/category_see_more_data.dart';
// import 'package:lenore/presentation/widgets/custom_app_bar.dart';

// class CategorySeeMoreScreen extends StatelessWidget {
//   final String name;
//   final Color colorName;
//   const CategorySeeMoreScreen(
//       {required this.name, required this.colorName, super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           SizedBox(
//             height: querySize.height * 0.03,
//           ),
//           const CustomAppABr(),
//           customSizedBox(querySize),
//           SizedBox(
//             height: querySize.height * 0.04,
//           ),
//           Container(
//             width: double.infinity,
//             height: querySize.height * 0.6,
//             padding: EdgeInsets.symmetric(horizontal: querySize.height * 0.045),
//             margin: EdgeInsets.symmetric(horizontal: querySize.height * 0.02),
//             decoration: BoxDecoration(
//               color: const Color(0x47F6DCC8),
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: querySize.height * 0.044,
//                 ),
//                 Text(
//                   "Product Cateogories",
//                   style: TextStyle(
//                       fontSize: querySize.height * 0.024,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Sitka'),
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.04,
//                 ),
//                 GridView.builder(
//                   itemCount: cateogorySeeMoreData.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisSpacing: 2,
//                     mainAxisExtent: 115,
//                     mainAxisSpacing: 2,
//                     crossAxisCount: 3,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return categorySeeMoreCard(
//                         cateogorySeeMoreData[index]['imagePath']!,
//                         cateogorySeeMoreData[index]['name']!,
//                         querySize);
//                   },
//                 )
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
