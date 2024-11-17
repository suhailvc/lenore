import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/delivery_fee_model/delivery_fee_model.dart';

Future<DeliveryFeeModel?> deliveryFeeApi() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/api/get-delivery-charge'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DeliveryFeeModel.fromJson(jsonResponse);
    } else {
      print(
          'Failed to fetch delivery fee. Status Code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error in deliveryFeeApi: $e');
    return null;
  }
}
