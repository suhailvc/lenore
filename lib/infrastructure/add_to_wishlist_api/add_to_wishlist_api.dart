import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<bool> addToWishListService(
    int productId, String quantity, String token) async {
  final url = Uri.parse('${baseUrl}/api/add-to-wishlist');
  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      print('added to wishlist');
      final data = json.decode(response.body);
      return data['status'] == true;
    } else {
      print(
          'Failed to add to wishlist: ${response.statusCode} - ${response.body}');
      return false;
    }
  } catch (e) {
    print('Exception in addToWishListService: $e');
    return false;
  }
}

// Future<bool> addToWishListService(
//     int productId, String quantity, String token) async {
//   final url = Uri.parse(
//       '${baseUrl}/api/add-to-wishlist?product_id=$productId&quantity=$quantity');
//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       print('200');
//       final data = json.decode(response.body);
//       if (data['status'] == true &&
//           data['message'] == 'Item has been added in your wishlist') {
//         print(data['message']);
//         return true;
//       } else {
//         print("remove from wish list");
//       }
//     } else {
//       print("Error: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Exception occurred: $e");
//   }
//   return false;
// }
