import 'package:flutter/material.dart';
import 'package:lenore/presentation/screens/landing_screen/landing_screen.dart';

import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Future<void> wait(BuildContext context) async {
//   // Check network connection
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Connect to the Internet and try again"),
//         duration: Duration(seconds: 2),
//       ),
//     );
//     return;
//   }

//   // Delay for 3.7 seconds
//   await Future.delayed(const Duration(milliseconds: 3700));

//   // Check if token exists
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('bearerToken');

//   // Navigate based on token presence
//   if (token != null) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const PersistantBottomNavBarScreen()),
//     );
//   } else {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const MobileNumberInputScreen()),
//     );
//   }
// }

wait(context) async {
  await Future.delayed(const Duration(milliseconds: 5800));
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
            builder: (context) =>
                LandingScreen() /*const MobileNumberInputScreen()*/));
  }
}
