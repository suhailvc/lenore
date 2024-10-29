import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:lenore/sample.dart';
import 'package:shared_preferences/shared_preferences.dart';

wait(context) async {
  await Future.delayed(const Duration(milliseconds: 3700));
  //GoRouter.of(context).pushReplacement(NamedRoutes().mobileNumber.path);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('bearerToken');
  if (token != null) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PersistantBottomNavBarScreen()));
  } else {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MobileNumberInputScreen()));
  }
}
