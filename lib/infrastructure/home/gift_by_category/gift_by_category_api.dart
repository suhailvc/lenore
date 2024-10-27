import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/home_model/gift_by_category/giftByCategoryModel.dart';

// Function to send mobile number via GET request with phone number in the URL
Future<GiftByCategoryModel?> giftByCategoryService() async {
  final url = Uri.parse('$baseUrl/api/get-categories');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final GiftByCategoryModel categoryList =
          GiftByCategoryModel.fromJson(responseData);
      return categoryList;
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
