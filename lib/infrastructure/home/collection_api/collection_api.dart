import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/home_model/collection_model/collection_model.dart';

Future<CollectionModel?> collectionService() async {
  final url = Uri.parse('$baseUrl/api/get-brands');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final CollectionModel collectionList =
          CollectionModel.fromJson(responseData);
      return collectionList;
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
