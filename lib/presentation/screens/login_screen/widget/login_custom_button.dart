import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/sample.dart';

ElevatedButton loginCustomButton(
  BuildContext context,
  Size querySize,
  String buttonText,
  Function onPressed,
) {
  return ElevatedButton(
    onPressed: () {
      onPressed();
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


// loginCustomButton(
//                     context,
//                     querySize,
//                     apiService.isLoading ? "Loading..." : "GET OTP",
//                     null, // Disable default navigation
//                     onPressed: () async {
//                       String phoneNumber = _phoneController.text.trim();
//                       if (phoneNumber.isNotEmpty) {
//                         // Send mobile number using the API service
//                         await apiService.sendMobileNumber(phoneNumber);

//                         // Navigate to OTP screen if the API call is successful
//                         if (apiService.resultMessage != null &&
//                             apiService.resultMessage == 'Success') {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const OtpScreen(),
//                             ),
//                           );
//                         } else {
//                           // Show error message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content:
//                                   Text(apiService.resultMessage ?? 'Error'),
//                             ),
//                           );
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Please enter a phone number"),
//                           ),
//                         );
//                       }
//                     },
//                   );