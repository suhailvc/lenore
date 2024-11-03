import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<String> logOutService(String token) async {
  final url = Uri.parse('${baseUrl}/api/logout');

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
      print('Failed to load order history: ${response.statusCode}');
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}
