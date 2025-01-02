import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<Map<String, dynamic>> invoiceIdService({
  required String orderId,
  required String invoiceId,
  required String token, // Added token parameter
}) async {
  final String url =
      '${baseUrl}/api/update-order-status?order_id=$orderId&InvoiceId=$invoiceId';

  try {
    // Define the headers to include the Bearer token
    final headers = {
      'Authorization': 'Bearer $token',
      // 'Content-Type': 'application/json', // Optional, depending on the API
    };

    // Making the GET request with headers
    final response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response if the status is 200
      final responseData = json.decode(response.body);
      print('fatoorah suuccess---------------');
      // Return the response data
      return {'status': 'success', 'data': responseData};
    } else {
      print('fatoorah failed1---------------');
      // Handle non-200 status codes
      return {'status': 'error', 'message': 'Failed to update order status'};
    }
  } catch (error) {
    print('fatoorah failed2---------------$error');
    // Handle any errors (network issues, exceptions, etc.)
    return {
      'status': 'error',
      'message': 'Connection error. Please try again later.'
    };
  }
}
