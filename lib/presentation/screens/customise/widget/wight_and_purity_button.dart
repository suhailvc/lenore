import 'package:flutter/material.dart';

Container weightAndPurityButton(Size querySize, String buttonName) {
  return Container(
    width: querySize.width * 0.25,
    height: querySize.height * 0.04,
    decoration: BoxDecoration(
        color: const Color(0xffEFEEEE),
        borderRadius: BorderRadius.circular(querySize.width * 0.03)),
    child: Center(
      child: Text(
        buttonName,
        style: TextStyle(
            fontSize: querySize.width * 0.038,
            fontWeight: FontWeight.w600,
            fontFamily: 'Segoe',
            color: const Color(0xFF8C8C8C)),
      ),
    ),
  );
}
