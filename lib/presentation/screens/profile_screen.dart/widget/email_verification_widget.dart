import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/infrastructure/delete_account_api/delete_account_api.dart';
import 'package:lenore/infrastructure/email_verification_api.dart/email_otp.dart';

import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

emailVerifyPopUp(BuildContext context, Size querySize) {
  final TextEditingController otpController =
      TextEditingController(); // Controller for OTP input

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.all(16.0), // Add padding for better spacing
        actionsPadding:
            const EdgeInsets.all(0), // Avoid extra padding between buttons
        actions: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column takes minimal vertical space
              children: [
                Padding(padding: EdgeInsets.only(right: querySize.width * 0.1)),
                customSizedBox(querySize),
                Text(
                  "OTP has been snet to your email",
                  textAlign: TextAlign.center, // Ensure text is centered
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: querySize.width * 0.038,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe',
                  ),
                ),
                SizedBox(
                  height: querySize.height * 0.01,
                ),
                Text(
                  "Enter OTP",
                  textAlign: TextAlign.center, // Ensure text is centered
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: querySize.width * 0.038,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe',
                  ),
                ),
                customSizedBox(querySize),
                // OTP TextField
                TextField(
                  controller: otpController, // Link controller to the TextField
                  keyboardType:
                      TextInputType.number, // Set input type to number
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.03),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: querySize.height * 0.015,
                      horizontal: querySize.width * 0.03,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: querySize.width * 0.038,
                    fontFamily: 'Segoe',
                  ),
                ),
                customSizedBox(querySize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: querySize.width * 0.3,
                        height: querySize.height * 0.04,
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
                              fontSize: querySize.height * 0.017,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: querySize.width * 0.01,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String enteredOtp = otpController.text.trim();
                        if (enteredOtp.isEmpty) {
                          customSnackBar(context, 'Please enter the OTP');
                          return;
                        }

                        String token = (await AuthProvider().getToken())!;
                        String response =
                            await emailOtpVerification(token, enteredOtp);
                        if (response == "email verified") {
                          Navigator.pop(context);
                        } else {
                          customSnackBar(context, 'Incorrect Otp');
                        }
                      },
                      child: Container(
                        width: querySize.width * 0.3,
                        height: querySize.height * 0.04,
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.08),
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.017,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
// emailVerifyPopUp(BuildContext context, Size querySize) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         contentPadding:
//             const EdgeInsets.all(16.0), // Add padding for better spacing
//         actionsPadding:
//             const EdgeInsets.all(0), // To avoid extra padding between buttons
//         actions: [
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize
//                   .min, // Ensures the column takes minimal vertical space
//               children: [
//                 Padding(padding: EdgeInsets.only(right: querySize.width * 0.1)),
//                 customSizedBox(querySize),
//                 Text(
//                   "OTP",
//                   textAlign: TextAlign.center, // Ensure text is centered
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: querySize.width * 0.038,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Segoe'),
//                 ),
//                 customSizedBox(querySize),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: querySize.width * 0.3,
//                         height: querySize.height * 0.04,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEBEBEB),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.08),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                                 fontFamily: 'Segoe',
//                                 fontSize: querySize.height * 0.017),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: querySize.width * 0.01,
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         String token = (await AuthProvider().getToken())!;
//                         String response = await deleteAccountService(token);
//                         if (response == 'success') {
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           await prefs.remove('bearerToken');
//                           Provider.of<CartProvider>(context, listen: false)
//                               .clearCart();
//                           // Navigator.pushReplacement(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => MobileNumberInputScreen()),
//                           // );
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MobileNumberInputScreen()),
//                             (Route<dynamic> route) => false,
//                           );
//                         } else {
//                           customSnackBar(context, 'failed to delete');
//                         }
//                       },
//                       child: Container(
//                         width: querySize.width * 0.3,
//                         height: querySize.height * 0.04,
//                         decoration: BoxDecoration(
//                           color: appColor,
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.08),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Submit',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                                 fontFamily: 'Segoe',
//                                 fontSize: querySize.height * 0.017),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 customSizedBox(querySize),
//               ],
//             ),
//           )
//         ],
//       );
//     },
//   );
// }
