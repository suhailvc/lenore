import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/product_listing_model/product_listing_model.dart';

Future<ProductListModel?> giftProductListService(
    String eventId, String pageNo) async {
  final url = Uri.parse(
      '$baseUrl/api/get-gifts-by-event?event_id=${eventId}&per_page=10&page=${pageNo}');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final ProductListModel productList =
          ProductListModel.fromJson(responseData);
      return productList;
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
