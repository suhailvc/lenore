import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

Padding customPaymentListTile(
    Size querySize, String iconPath, String name, String tickImage) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.02),
    child: Row(
      children: [
        Image.asset(
          iconPath,
          width: querySize.width * 0.069,
          height: querySize.height * 0.035,
        ),
        SizedBox(width: querySize.width * 0.05),
        Text(
          name,
          style: TextStyle(
              color: const Color(0xFF858585),
              fontWeight: FontWeight.w600,
              fontFamily: 'Segoe',
              fontSize: querySize.width * 0.039),
        ),
        const Spacer(),
        Image.asset(
            width: querySize.width * (17 / 375),
            height: querySize.height * (17 / 812),
            tickImage),
      ],
    ),
  );
}
