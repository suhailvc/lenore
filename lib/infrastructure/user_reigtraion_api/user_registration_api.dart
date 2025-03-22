import 'dart:convert';
import 'dart:io';

import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:lenore/domain/user_registration_model/user_registration_data_taken.dart';
import 'package:lenore/domain/user_registration_model/user_registration_success_model.dart';
import 'package:lenore/presentation/widgets/shared_pref_method.dart';
import 'package:provider/provider.dart';

Future<dynamic> userRegistrationService({
  required context,
  required String fName,
  required String sName,
  required String email,
  required String qId,
  required String gender,
  required bool term,
  required String countryId,
  required String mobileNumber,
  required List<File> documents, // List of files for images
}) async {
  final String url =
      '$baseUrl/api/register?f_name=$fName&l_name=$sName&email=$email&q_id=$qId&gender=$gender&terms=$term&phone=$mobileNumber&country=$countryId';

  try {
    print('API called with URL: $url');

    // Create a multipart request
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Attach files (images/documents)
    for (int i = 0; i < documents.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'document[$i]', // Array-like naming convention
        documents[i].path,
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Success -----------------------------------');
      final responseData = json.decode(response.body);

      if (responseData['response_code'] == '3') {
        print('User registered -----------------------------------');
        final UserRegistrationSuccessModel userRegistration =
            UserRegistrationSuccessModel.fromJson(responseData);
        await Provider.of<AuthProvider>(context, listen: false)
            .setToken(userRegistration.token.toString());

        return userRegistration;
      } else if (responseData['response_code'] == '0') {
        print('Field already present -----------------------------------');
        final UserRegistrationDataTakenModel userRegistration =
            UserRegistrationDataTakenModel.fromJson(responseData);
        return userRegistration;
      } else {
        print('Unexpected response code -----------------------------------');
        return {
          'error': 'Unexpected response code: ${responseData['response_code']}',
        };
      }
    } else {
      print('Server error -----------------------------------');
      return {'error': 'Server error. Please try again later.'};
    }
  } catch (error) {
    print('Connection error -----------------------------------');
    return {'error': 'Connection error. Please try again later.'};
  }
}

// Future<dynamic> userRegistrationService(
//     {required context,
//     required String fName,
//     required String sName,
//     required String email,
//     required String qId,
//     required String gender,
//     required bool term,
//     required String mobileNumber}) async {
//   final String url =
//       '$baseUrl/api/register?f_name=$fName&l_name=$sName&email=$email&q_id=$qId&gender=$gender&terms=$term&phone=$mobileNumber';

//   try {
//     print(
//         'api called-------------------------------------------------------------');
//     final response = await http.post(Uri.parse(url));

//     if (response.statusCode == 200) {
//       print('sucees-----------------------------------');
//       final responseData = json.decode(response.body);

//       if (responseData['response_code'] == '3') {
//         print('user registered-----------------------------------');
//         final UserRegistrationSuccessModel userRegistration =
//             UserRegistrationSuccessModel.fromJson(responseData);
//         await Provider.of<AuthProvider>(context, listen: false)
//             .setToken(userRegistration.token.toString());

//         return userRegistration;
//       } else if (responseData['response_code'] == '0') {
//         print('fieled alredy present-----------------------------------');
//         final UserRegistrationDataTakenModel userRegistration =
//             UserRegistrationDataTakenModel.fromJson(responseData);
//         return userRegistration;
//       } else {
//         print('errrrorrrrrrr-----------------------------------');
//         return {
//           'error': 'Unexpected response code: ${responseData['response_code']}'
//         };
//       }
//     } else {
//       print('handserveerrrrorrrrrrr-----------------------------------');
//       return {'error': 'Server error. Please try again later.'};
//     }
//   } catch (error) {
//     print('handNNetweerrrrorrrrrrr-----------------------------------');
//     return {'error': 'Connection error. Please try again later.'};
//   }
// }
