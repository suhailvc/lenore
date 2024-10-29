import 'dart:convert';

import 'package:lenore/core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:lenore/domain/user_registration_model/user_registration_data_taken.dart';
import 'package:lenore/domain/user_registration_model/user_registration_success_model.dart';
import 'package:lenore/presentation/widgets/shared_pref_method.dart';

Future<dynamic> userRegistrationService(
    {required String fName,
    required String sName,
    required String email,
    required String qId,
    required String gender,
    required bool term,
    required String mobileNumber}) async {
  final String url =
      '$baseUrl/api/register?f_name=$fName&l_name=$sName&email=$email&q_id=$qId&gender=$gender&terms=$term&phone=$mobileNumber';

  try {
    print(
        'api called-------------------------------------------------------------');
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print('sucees-----------------------------------');
      final responseData = json.decode(response.body);

      if (responseData['response_code'] == '3') {
        print('user registered-----------------------------------');
        final UserRegistrationSuccessModel userRegistration =
            UserRegistrationSuccessModel.fromJson(responseData);
        saveToken(userRegistration.token.toString());
        return userRegistration;
      } else if (responseData['response_code'] == '0') {
        print('fieled alredy present-----------------------------------');
        final UserRegistrationDataTakenModel userRegistration =
            UserRegistrationDataTakenModel.fromJson(responseData);
        return userRegistration;
      } else {
        print('errrrorrrrrrr-----------------------------------');
        return {
          'error': 'Unexpected response code: ${responseData['response_code']}'
        };
      }
    } else {
      print('handserveerrrrorrrrrrr-----------------------------------');
      return {'error': 'Server error. Please try again later.'};
    }
  } catch (error) {
    print('handNNetweerrrrorrrrrrr-----------------------------------');
    return {'error': 'Connection error. Please try again later.'};
  }
}
