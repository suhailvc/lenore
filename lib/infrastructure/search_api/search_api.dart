import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/search_model/search_model.dart';

Future<SearchModel?> searchService(String key) async {
  final String url = '${baseUrl}/api/search-product?key=$key';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('---------------$data');
      return SearchModel.fromJson(data);
    } else {
      print('Failed to load search results: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error occurred: $e');
    return null;
  }
}
