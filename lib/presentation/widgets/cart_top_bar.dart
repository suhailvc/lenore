import 'package:flutter/material.dart';

cartTopBar(Size querySize, BuildContext context, String screenName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/back_blue_icon.png',
          height: querySize.height * 0.033,
        ),
      ),
      // SizedBox(
      //   width: querySize.width * 0.22,
      // ),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            screenName,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: querySize.width * (32 / 375),
                color: const Color(0xFF008186),
                fontFamily: 'ElMessirisemibold'),
          ),
        ),
      ),
    ],
  );
}
