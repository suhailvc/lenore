import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/order_history_model/order_history_model.dart';

Future<OrderHistoryModel?> fetchOrderHistoryService(String token) async {
  final url = Uri.parse('${baseUrl}/api/order-history');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return OrderHistoryModel.fromJson(data);
    } else {
      print('Failed to load order history: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
