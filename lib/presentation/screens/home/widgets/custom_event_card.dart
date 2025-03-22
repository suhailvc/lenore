import 'package:flutter/material.dart';
import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';
import 'package:lenore/presentation/screens/sub_category_product_listing_screen/sub_category_product_listing_screen.dart';
import 'package:flutter_html/flutter_html.dart';

// Widget buildEventCard(String imagePath, String title, Size querySize,
//     BuildContext context, int eventId) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SubCategoryProductListingScreen(
//             eventName: 'gift-by-event',
//             productListingScreenName: title,
//             eventId: eventId,
//           ),
//         ),
//       );
//     },
//     child: Container(
//       width: querySize.width * 0.25, // Control overall width
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.network(
//             imagePath,
//             height: querySize.height * 0.037,
//             fit: BoxFit.contain,
//           ),
//           SizedBox(height: 5),
//           Flexible(
//             child: Html(
//               data: title,
//               shrinkWrap: true,
//               style: {
//                 "p": Style(
//                   margin: Margins.zero,
//                   padding: HtmlPaddings.zero,
//                 ),
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
Widget buildEventCard(String imagePath, String title, Size querySize,
    BuildContext context, int eventId) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryProductListingScreen(
              eventName: 'gift-by-event',
              productListingScreenName: title,
              eventId: eventId,
            ),
          ));
    },
    child: Container(
      decoration: BoxDecoration(
          // shape: BoxShape.circle,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.3),
          //     spreadRadius: 2,
          //     blurRadius: 8,
          //     offset: const Offset(3, 4),
          //   ),
          // ],
          ),
      // child: CircleAvatar(
      //   radius: querySize.height * 0.06,
      // backgroundColor: const Color(0xFFFFF6E9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imagePath, height: querySize.height * 0.037),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.015,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // ),
    ),
  );
}
