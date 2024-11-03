import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

customSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: textColor,
    ),
  );
}
