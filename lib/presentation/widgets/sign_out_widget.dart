import 'package:flutter/material.dart';

Container askSignIn(Size querySize) {
  return Container(
    color: Colors.white,
    height: querySize.height * 0.7,
    width: querySize.width * 1,
    child: Center(
      child: Text("Please SignIn",
          style: TextStyle(
              fontSize: querySize.height * 0.02,
              fontWeight: FontWeight.w600,
              fontFamily: 'Segoe',
              color: Color(0xFF5E5E5E))),
    ),
  );
}
