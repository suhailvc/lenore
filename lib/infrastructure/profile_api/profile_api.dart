import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/profile_model/profile_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/profile_model/profile_model.dart';

Future<ProfileModel?> getProfileDetailsService(String token) async {
  final url = Uri.parse('${baseUrl}/api/get-profile');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('API response: ${response.body}'); // Debugging: Print API response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProfileModel.fromJson(data);
    } else {
      print('Failed to load profile: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching profile details: $e');
    return null;
  }
}

// Future<ProfileModel?> getProfileDetailsService(String token) async {
//   final url = Uri.parse('${baseUrl}/api/get-profile');

//   try {
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return ProfileModel.fromJson(data);
//     } else {
//       print('Failed to load profile: ${response.statusCode}');
//       return null;
//     }
//   } catch (e) {
//     print('Error fetching profile details: $e');
//     return null;
//   }
// }
