import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

Column customBestSeller(Size querySize) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Best Seller",
        style: TextStyle(
          fontSize: querySize.height * 0.025,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sitka',
        ),
      ),
      customSizedBox(querySize),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: querySize.height * 0.015,
          mainAxisSpacing: querySize.height * 0.004,
          childAspectRatio: 0.46,
        ),
        itemBuilder: (context, index) {
          return buildProductItem(querySize, index);
        },
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          "See more ...",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: querySize.height * 0.011,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

Widget buildProductItem(Size querySize, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: querySize.height * 0.09,
        decoration: BoxDecoration(
          color: const Color(0xFFE7E7E7),
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: index % 2 == 0
                ? const AssetImage("assets/images/home/best seller one.png")
                : const AssetImage("assets/images/home/best seller two.png"),
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
