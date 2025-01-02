import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/order_status_model/order_status_model.dart';

class OrderStatusService {
  final String apiUrl = "${baseUrl}/api/track-order";

  Future<OrderStatusModel> orderStatusService(
      String orderId, String token) async {
    try {
      final Uri uri = Uri.parse('$apiUrl?order_id=$orderId');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          return OrderStatusModel.fromJson(jsonResponse);
        } else {
          throw Exception(jsonResponse['message'] ?? 'Unknown error occurred');
        }
      } else {
        throw Exception(
            'Failed to fetch order status. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred: $error');
    }
  }
}
