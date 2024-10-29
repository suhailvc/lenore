import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

logOutPopUp(BuildContext context, Size querySize) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.all(16.0), // Add padding for better spacing
        actionsPadding:
            const EdgeInsets.all(0), // To avoid extra padding between buttons
        actions: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column takes minimal vertical space
              children: [
                Padding(padding: EdgeInsets.only(right: querySize.width * 0.1)),
                customSizedBox(querySize),
                Image.asset(
                  'assets/images/log_out.png',
                  width: querySize.width * 0.5,
                  height: querySize.height * 0.055,
                ),
                customSizedBox(querySize),
                Text(
                  "Are you sure you want to log out?",
                  textAlign: TextAlign.center, // Ensure text is centered
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: querySize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Segoe'),
                ),
                customSizedBox(querySize),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('bearerToken');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobileNumberInputScreen()),
                    );
                  },
                  child: Container(
                    width: querySize.width * 0.5,
                    height: querySize.height * 0.048,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.08),
                    ),
                    child: Center(
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Segoe',
                            fontSize: querySize.height * 0.017),
                      ),
                    ),
                  ),
                ),
                customSizedBox(querySize),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: querySize.width * 0.5,
                    height: querySize.height * 0.048,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBEBEB),
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.08),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Segoe',
                            fontSize: querySize.height * 0.017),
                      ),
                    ),
                  ),
                ),
                customSizedBox(querySize),
              ],
            ),
          )
        ],
      );
    },
  );
}
