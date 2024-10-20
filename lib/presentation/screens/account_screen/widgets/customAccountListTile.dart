import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

Padding customAccountListTile(Size querySize, String iconPath, String name) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.05),
    child: Row(
      children: [
        Image.asset(
          iconPath,
          width: querySize.width * (22 / 375),
          height: querySize.height * (22 / 812),
        ),
        SizedBox(width: querySize.width * 0.05),
        Text(
          name,
          style: TextStyle(
              color: name == "Delete Account" ? Colors.red : textColor,
              fontWeight: FontWeight.w400,
              fontFamily: 'Segoe',
              fontSize: querySize.width * (16 / 375)),
        ),
        const Spacer(),
        Image.asset(
            width: querySize.width * (15 / 375),
            height: querySize.height * (15 / 812),
            "assets/images/account/forward_icon.png"),
      ],
    ),
  );
}
