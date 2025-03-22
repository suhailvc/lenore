import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/otp_model/existing_user_otp_model.dart';
import 'package:lenore/domain/otp_model/new_user_otp_model.dart';

import 'package:provider/provider.dart';

class OtpApiService {
  // Function to verify OTP
  Future<dynamic> verifyOtp(
      String mobileNumber, String otp, BuildContext context) async {
    final String url =
        '$baseUrl/api/confirm-otp?phone=${mobileNumber}&otp=$otp&fcm_token=$fcm_token';
    // final String url = '$baseUrl/api/confirm-otp?phone=$mobileNumber&otp=1234';
    try {
      print(
          'api called-------------------------------------------------------------');
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        print('sucees-----------------------------------');

        final responseData = json.decode(response.body);
        print(responseData['response_code']);
        if (responseData['response_code'] == '1') {
          print('new user-----------------------------------');
          // New User: response_code == 1, Return NewUserOtpModel final ExistingUserOtpModel user =
          final NewUserOtpModel newUser =
              NewUserOtpModel.fromJson(responseData);
          return newUser;
        }
        if (responseData['response_code'] == '2') {
          print('exiting user-----------------------------------');
          // Existing User: response_code == 2, Return ExistingUserOtpModel
          final ExistingUserOtpModel existingUser =
              ExistingUserOtpModel.fromJson(responseData);
          print('shared preffffffff-----------------------------------');
          await Provider.of<AuthProvider>(context, listen: false)
              .setToken(existingUser.token.toString());

          return existingUser;
        } else if (responseData['response_code'] == '0') {
          print('incorrect-----------------------------------');
          // Incorrect OTP: response_code == 0
          return {'Incorrect OTP'};
        } else {
          print('errrrorrrrrrr-----------------------------------');
          return {
            'error':
                'Unexpected response code: ${responseData['response_code']}'
          };
        }
      } else {
        print('handserveerrrrorrrrrrr-----------------------------------');
        // Handle server error
        return {'error': 'Server error. Please try again later.'};
      }
    } catch (error) {
      print('handNNetweerrrrorrrrrrr-----------------------------------$error');
      // Handle network error
      return {'error': 'Connection error. Please try again later.'};
    }
  }
}
