import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<void> emailVerificationApi(String token) async {
  String url = '$baseUrl/api/sent-verify-email-request';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle success response
      print('Email verification request sent successfully: ${response.body}');
    } else {
      // Handle error response
      print('Failed to send email verification request: ${response.body}');
    }
  } catch (error) {
    // Handle exceptions
    print('Error in emailVerificationApi: $error');
  }
}
