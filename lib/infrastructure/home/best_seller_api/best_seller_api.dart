import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/home_model/best_seller_model/best_seller_model.dart';

Future<BestSellerModel?> bestSellerService() async {
  final url = Uri.parse('$baseUrl/api/best-sellers');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final BestSellerModel bestSellerList =
          BestSellerModel.fromJson(responseData);
      return bestSellerList;
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
