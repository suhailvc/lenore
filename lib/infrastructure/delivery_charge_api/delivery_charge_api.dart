import 'dart:convert';

import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/delivery_charge_model/delivery_charge_model.dart';
import 'package:http/http.dart' as http;

Future<DeliveryChargeResponse?> deliveryChargeApi(
    List<DeliveryChargeRequestProduct> products) async {
  try {
    final url = Uri.parse('$baseUrl/api/get-custom-delivery-charge');

    // Prepare request body
    final Map<String, dynamic> requestBody = {
      'products': products.map((product) => product.toJson()).toList(),
    };

    // Print the request body for debugging
    print("Delivery charge API request body: ${json.encode(requestBody)}");

    // Make POST request
    final response = await http.post(
      url,
      // Send as form data instead of JSON
      body: {
        'products':
            json.encode(products.map((product) => product.toJson()).toList()),
      },
    );

    print("API Response status code: ${response.statusCode}");
    print("API Response body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DeliveryChargeResponse.fromJson(jsonResponse);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception occurred while fetching delivery charge: $e');
    return null;
  }
}
// Future<DeliveryChargeResponse?> deliveryChargeApi(
//     List<DeliveryChargeRequestProduct> products) async {
//   try {
//     final url = Uri.parse('$baseUrl/api/get-custom-delivery-charge');

//     // Prepare request body
//     final Map<String, dynamic> requestBody = {
//       'products': products.map((product) => product.toJson()).toList(),
//     };

//     // Make POST request
//     final response = await http.post(
//       url,
//       body: json.encode(requestBody),
//       // headers: {
//       //   'Content-Type': 'application/json',
//       // },
//     );

//     if (response.statusCode == 200) {
//       print('-----------response 200');
//       final jsonResponse = json.decode(response.body);
//       return DeliveryChargeResponse.fromJson(jsonResponse);
//     } else {
//       print('Error: ${response.statusCode} - ${response.body}');
//       return null;
//     }
//   } catch (e) {
//     print('Exception occurred while fetching delivery charge: $e');
//     return null;
//   }
// }
