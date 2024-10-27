// mobile_number_service.dart

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/mobile_number_model/mobile_number_model.dart';

// Function to send mobile number via GET request with phone number in the URL
Future<MobileNumberModel?> sendMobileNumberService(String phoneNumber) async {
  print("--------------------$phoneNumber");
  final url = Uri.parse('$baseUrl/api/sent-mobile-number?phone=$phoneNumber');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      log('----------------------------------------------');
      final jsonResponse = json.decode(response.body);
      print(MobileNumberModel.fromJson(jsonResponse));
      return MobileNumberModel.fromJson(jsonResponse);
    } else {
      print('eeeeeeeeerrrrrrrrrrr');
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}



// import 'dart:convert'; // For JSON encoding/decoding
// import 'package:http/http.dart' as http;
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/domain/mobile_number_model/mobile_number_model.dart';

// Future<MobileNumberModel?> sendMobileNumber(String phoneNumber) async {
//   _isLoading = true;
//   notifyListeners(); // Notify UI that loading has started

//   final url = Uri.parse(baseUrl);

//   try {
//     // Create the request body
//     final Map<String, String> requestBody = {
//       'phone': phoneNumber,
//     };

//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: json.encode(requestBody), // Encode the request body as JSON
//     );

//     if (response.statusCode == 200) {
//       // If the server returns a response, parse it
//       final jsonResponse = json.decode(response.body);
//       MobileNumberModel model = MobileNumberModel.fromJson(jsonResponse);
//       _resultMessage = model.message ?? 'Success';
//     } else {
//       _resultMessage = 'Error: ${response.statusCode}';
//     }
//   } catch (e) {
//     // Handle exceptions like network errors
//     _resultMessage = 'Exception: $e';
//   } finally {
//     _isLoading = false;
//     notifyListeners(); // Notify UI that loading has ended
//   }
//   // // final url = Uri.parse('$baseUrl?phone=$phoneNumber');
//   // final url = Uri.parse('$baseUrl?api/sent-mobile-number?phone=$phoneNumber');

//   // try {
//   //   final response = await http.get(url); // Sending GET request

//   //   if (response.statusCode == 200) {
//   //     // Parsing the response
//   //     final Map<String, dynamic> jsonResponse = json.decode(response.body);
//   //     return MobileNumberModel.fromJson(jsonResponse);
//   //   } else {
//   //     // Handle error
//   //     print("Error: ${response.statusCode}");
//   //     return null;
//   //   }
//   // } catch (e) {
//   //   // Handle exceptions like network errors
//   //   print("Exception: $e");
//   //   return null;
//   // }
// }
