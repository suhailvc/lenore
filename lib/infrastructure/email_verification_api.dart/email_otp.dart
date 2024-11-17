import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<String> emailOtpVerification(String token, String otp) async {
  //String baseUrl = '$baseUrl/api/verify-email-otp';

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/verify-email-otp?otp=$otp'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Return the message from the API response
      return responseData['message'] ?? 'Unknown response message';
    } else {
      return 'Error: ${response.statusCode}, ${response.reasonPhrase}';
    }
  } catch (error) {
    return 'Error: $error';
  }
}
