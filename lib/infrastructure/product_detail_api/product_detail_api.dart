import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/product_detail_model/product_detail_model.dart';

Future<ProductDetailModel?> productDetailService(int id) async {
  final url = Uri.parse('$baseUrl/api/product-details?id=${id}');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Check if the responseData has the expected structure
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('status') &&
          responseData.containsKey('data')) {
        // Deserialize the data into ProductDetailModel
        final ProductDetailModel productDetail =
            ProductDetailModel.fromJson(responseData);
        return productDetail;
      } else {
        print(
            'Unexpected response structure for product ID $id: $responseData');
        return null;
      }
    } else {
      print('Product detail error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
// Future<ProductDetailModel?> productDetailService(int id) async {
//   final url = Uri.parse('$baseUrl/api/product-details?id=${id}');

//   try {
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       print(responseData['response_code']);

//       final ProductDetailModel productDetail =
//           ProductDetailModel.fromJson(responseData);
//       return productDetail;
//     } else {
//       print('product detail error: ${response.statusCode}');
//       return null;
//     }
//   } catch (e) {
//     print('Exception: $e');
//     return null;
//   }
// }
