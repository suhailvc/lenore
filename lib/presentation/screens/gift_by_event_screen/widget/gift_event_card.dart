import 'package:flutter/material.dart';

Widget giftEventCard(String imagePath, String title, Size querySize) {
  return SizedBox(
    height: querySize.width * 0.3,
    child: Container(
      width: querySize.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: querySize.height * 0.035),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.009,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
