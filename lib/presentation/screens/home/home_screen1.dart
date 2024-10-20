// import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_best_seller.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_category_card.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_event_card.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_event_message_field.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_gift_voucher_card.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_home_top_bar.dart';

// class HomeScreen1 extends StatelessWidget {
//   const HomeScreen1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Scrollbar(
//           interactive: true,
//           thickness: 3,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(querySize.height * 0.02),
//                   child: customHomeTopBar(querySize),
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.01,
//                 ),
//                 customEventMessageField(querySize),
//                 customSizedBox(querySize),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: querySize.height * 0.05),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Gift By Event",
//                         style: TextStyle(
//                           fontSize: querySize.height * 0.025,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Sitka',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       GridView.count(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 16.0,
//                         mainAxisSpacing: 16.0,
//                         childAspectRatio: 1.1,
//                         children: [
//                           buildEventCard("assets/images/home/Birth Day.png",
//                               "Birthday", querySize),
//                           buildEventCard("assets/images/home/Graduation.png",
//                               "Graduation", querySize),
//                           buildEventCard(
//                               "assets/images/home/Love.png", "Love", querySize),
//                           buildEventCard("assets/images/home/New Born.png",
//                               "New Born", querySize),
//                           buildEventCard("assets/images/home/aniversary.png",
//                               "Anniversarys", querySize),
//                           buildEventCard("assets/images/home/wedding.png",
//                               "Wedding", querySize),
//                           buildEventCard(
//                               "assets/images/home/omra.png", "Omra", querySize),
//                           buildEventCard("assets/images/home/ramdan.png",
//                               "Ramadan", querySize),
//                         ],
//                       ),
//                       SizedBox(height: querySize.height * 0.01),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           "See more ...",
//                           style: TextStyle(
//                             fontFamily: 'Raleway',
//                             fontSize: querySize.height * 0.011,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: querySize.height * 0.02,
//                       ),
//                       const Divider(),
//                     ],
//                   ),
//                 ),
//                 customSizedBox(querySize),
//                 customCategoriesCard(
//                     const Color(0xFFFCEDE2),
//                     querySize,
//                     "Product Categories",
//                     "Diamond",
//                     "assets/images/home/diamond.png",
//                     "Pearl",
//                     "assets/images/home/pearl.png",
//                     "Gold",
//                     "assets/images/home/gold.png",
//                     "Sets",
//                     "assets/images/home/sets.png"),
//                 customSizedBox(querySize),
//                 customDivider(querySize),
//                 customSizedBox(querySize),
//                 giftVoucherCard(querySize, context),
//                 customHeightThree(querySize),
//                 customDivider(querySize),
//                 customHeightThree(querySize),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: querySize.height * 0.05),
//                   child: customBestSeller(querySize),
//                 ),
//                 customSizedBox(querySize),
//                 customDivider(querySize),
//                 customSizedBox(querySize),
//                 customCategoriesCard(
//                     const Color(0xFFDFEFD6),
//                     querySize,
//                     "Brands",
//                     "Warda",
//                     "assets/images/home/warda image.png",
//                     "Zri",
//                     "assets/images/home/zri image.png",
//                     "Laura",
//                     "assets/images/home/laura image.png",
//                     "Maraya",
//                     "assets/images/home/maraya image.png"),
//                 customSizedBox(querySize),
//                 customDivider(querySize),
//                 customSizedBox(querySize),
//                 customCategoriesCard(
//                     const Color(0xFFECEAE6),
//                     querySize,
//                     "New Arrival",
//                     "Warda",
//                     "assets/images/home/warda image.png",
//                     "Zri",
//                     "assets/images/home/zri image.png",
//                     "Laura",
//                     "assets/images/home/laura image.png",
//                     "Maraya",
//                     "assets/images/home/maraya image.png"),
//                 SizedBox(
//                   height: querySize.height * 0.06,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
