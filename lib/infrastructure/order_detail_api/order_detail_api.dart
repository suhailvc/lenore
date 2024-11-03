import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/order_detail_model/order_detail_model.dart';

Future<OrderDetailModel?> fetchOrderDetailService(
    String token, String orderId) async {
  final url = Uri.parse('${baseUrl}/api/order-details?order_id=${orderId}');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return OrderDetailModel.fromJson(data);
    } else {
      print("no 200");
      print('Failed to load order history: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
