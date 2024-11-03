import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<bool> isProductInWishlist(String token, int productId) async {
  final url =
      Uri.parse('${baseUrl}/api/check-in-wishlist?product_id=$productId');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['status'] == true;
    } else {
      print('Failed to check wishlist: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error checking wishlist: $e');
    return false;
  }
}
