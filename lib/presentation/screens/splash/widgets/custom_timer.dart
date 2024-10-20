import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/sample.dart';

wait(context) async {
  await Future.delayed(const Duration(milliseconds: 3700));
  //GoRouter.of(context).pushReplacement(NamedRoutes().mobileNumber.path);
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => const MobileNumberInputScreen()));
}
