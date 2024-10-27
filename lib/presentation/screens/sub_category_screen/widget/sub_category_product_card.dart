import 'package:flutter/material.dart';
import 'package:lenore/presentation/screens/sub_category_product_listing_screen/sub_category_product_listing_screen.dart';

Widget subCategoryCard(
  String imagePath,
  String title,
  Size querySize,
  BuildContext context,
  int id,
  String eventName,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryProductListingScreen(
                eventId: id,
                eventName: eventName,
                productListingScreenName: title),
          ));
    },
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(3, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: querySize.height * 0.06,
        backgroundColor: const Color(0xFFFFF6E9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imagePath,
                height: querySize.height * 0.037,
                filterQuality: FilterQuality.high),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.011,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
