import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/sample.dart';

ElevatedButton loginCustomButton(
  BuildContext context,
  Size querySize,
  String buttonText,
  screenName,
) {
  return ElevatedButton(
    onPressed: () {
      //  GoRouter.of(context).pushReplacement(NamedRoutes().home.path);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screenName,
          ));
    },
    style: ElevatedButton.styleFrom(
      minimumSize: Size(querySize.width * 0.85, querySize.height * 0.06),
      backgroundColor: appColor,
      padding: EdgeInsets.symmetric(
        horizontal: querySize.width * 0.15,
        vertical: querySize.height * 0.02,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(querySize.width * 0.08),
      ),
    ),
    child: Text(
      buttonText,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Jost'),
    ),
  );
}
