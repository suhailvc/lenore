import 'package:flutter/material.dart';

import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';
import 'package:lenore/domain/user_registration_model/user_registration_data_taken.dart';
import 'package:lenore/domain/user_registration_model/user_registration_success_model.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

Future<void> handleOtpSubmission(
    {required BuildContext context,
    required String fName,
    required String sName,
    required String email,
    required String qId,
    required String gender,
    required bool term,
    required String mobileNumber}) async {
  final userRegistrationProvider =
      Provider.of<UserRegistrationProvider>(context, listen: false);

  // if (otp.isEmpty) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Please enter the OTP')),
  //   );
  //   return;
  // }

  var response = await userRegistrationProvider.userRegistration(
      context: context,
      fName: fName,
      sName: sName,
      email: email,
      qId: qId,
      gender: gender,
      term: term,
      mobileNumber: mobileNumber);

  if (response is UserRegistrationSuccessModel) {
    print(response);
    // Navigate to Home Screen if the user exists
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const PersistantBottomNavBarScreen()),
    );
  } else if (response is UserRegistrationDataTakenModel) {
    print(response);
    // Navigate to Registration Screen for new users
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('check entered data')),
    );
  } else if (response is Map<String, dynamic> &&
      response.containsKey('error')) {
    print(response);
    print('ui error-------------------------------------------');
    // Show error message for incorrect OTP
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['error'])),
    );
  }
}
