import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<String> deleteAccountService(String token) async {
  final url = Uri.parse('${baseUrl}/api/delete-account');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return 'success';
    } else {
      print('Failed to delete: ${response.statusCode}');
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}
