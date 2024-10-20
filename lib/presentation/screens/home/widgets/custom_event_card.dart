import 'package:flutter/material.dart';
import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';

Widget buildEventCard(
    String imagePath, String title, Size querySize, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListingScreen(
              productListingScreenName: title,
            ),
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
            Image.asset(imagePath, height: querySize.height * 0.037),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: querySize.height * 0.011,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF646464),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
