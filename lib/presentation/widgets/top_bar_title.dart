import 'package:flutter/material.dart';

topBarTitle(Size querySize, BuildContext context, String screenName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
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
                fontSize: querySize.width * (30 / 375),
                color: const Color(0xFF008186),
                fontFamily: 'ElMessirisemibold'),
          ),
        ),
      ),
    ],
  );
}
