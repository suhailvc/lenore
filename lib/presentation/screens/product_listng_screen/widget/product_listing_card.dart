import 'package:flutter/material.dart';

Widget productListingCard(Size querySize, int index, String imagePath) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: querySize.height * 0.2,
        decoration: BoxDecoration(
          color: const Color(0xFFE7E7E7),
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: querySize.height * 0.01),
      const Row(
        children: [
          Text(
            "756",
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 13.0,
            ),
          ),
          Text(
            "  QR",
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const Text(
        "Product",
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF707070),
        ),
      ),
      const Text(
        "Name and Price Laura",
        style: TextStyle(
          fontSize: 6,
          color: Color(0xFF707070),
        ),
      ),
    ],
  );
}
