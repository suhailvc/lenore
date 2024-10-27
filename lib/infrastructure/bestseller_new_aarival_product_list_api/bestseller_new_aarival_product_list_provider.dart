import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/product_listing_model/product_listing_model.dart';

Future<ProductListModel?> bestSellerNewArrivalproductListService(
    String pageNo, String eventName, int? id) async {
  final url = Uri.parse(
      '$baseUrl/api/products-list?filter_type=${eventName}&id=${id}&per_page=5&page=${pageNo}');

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
