import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        width: querySize.width * 1,
        height: querySize.height * 0.89,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: querySize.height * 0.17,
            ),
            Image.asset(
              'assets/images/payment_success.png',
              width: querySize.width * 0.2,
              height: querySize.height * 0.087,
            ),
            customSizedBox(querySize),
            Text(
              '         Thank you!\nYor order is confirmed',
              style: TextStyle(
                  color: const Color(0xFF353E4D),
                  fontSize: querySize.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe'),
            ),
            SizedBox(
              height: querySize.height * 0.29,
            ),
            Text(
              'Check the order status through\n                 order status',
              style: TextStyle(
                  color: const Color(0xFF353E4D),
                  fontSize: querySize.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe'),
            ),
            customSizedBox(querySize),
            ElevatedButton(
              onPressed: () async {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: PersistantBottomNavBarScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00ACB3),
                minimumSize: Size(
                  querySize.width * 0.8,
                  querySize.height * (48 / 812),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(querySize.width * 0.06),
                ),
              ),
              child: const Text(
                'Back to home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
