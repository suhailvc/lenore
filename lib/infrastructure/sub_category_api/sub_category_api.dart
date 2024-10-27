import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/sub_category_model/sub_category_model.dart';

Future<SubCategoryModel?> subCategoryService(
    String categoryName, String id) async {
  final url = Uri.parse(
      '$baseUrl/api/get-subcategories?filter_type=${categoryName}&id=${id}');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final SubCategoryModel subCategoryProductList =
          SubCategoryModel.fromJson(responseData);
      return subCategoryProductList;
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
