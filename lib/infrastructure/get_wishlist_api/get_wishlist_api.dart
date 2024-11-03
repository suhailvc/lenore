import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/get_wishlist_model/get_wishlist_model.dart';

Future<GetWishListModel?> getWishListService(String token) async {
  final url = Uri.parse('${baseUrl}/api/get-wishlist');
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetWishListModel.fromJson(data);
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception occurred: $e");
  }
  return null;
}
