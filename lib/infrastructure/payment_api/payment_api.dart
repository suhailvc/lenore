import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

Future<int?> paymentService(
    {required String token,
    required String addressId,
    required String paymentMethod,
    required List<Map<String, dynamic>> cart,
    required double totalAmount,
    required double discount,
    required String couponCode,
    required double deliveryCharge,
    required int quantity,
    required double walletUsed}) async {
  String url = '${baseUrl}/api/place-order';
  print('discount: $discount');
  print('couponcode : $couponCode');
  print('delivery charge: $deliveryCharge');
  print('Address ID: $addressId');
  print('Payment Method: $paymentMethod');
  print('Total Amount: $totalAmount');
  print('Quantity: $quantity');
  print('Cart: $cart');
  // Create the MultipartRequest
  var request = http.MultipartRequest('POST', Uri.parse(url));

  // Add headers
  request.headers.addAll({
    'Authorization': 'Bearer $token',
    'Content-Type': 'multipart/form-data',
  });

  // Add form fields
  request.fields['address_id'] = addressId;
  request.fields['payment_method'] = paymentMethod;
  request.fields['total_amount'] = totalAmount.toString();
  request.fields['discount'] = discount.toString();
  request.fields['coupon_code'] = couponCode;
  request.fields['delivery_charge'] = deliveryCharge.toString();
  request.fields['quantity'] = quantity.toString();
  request.fields['wallet_used'] = walletUsed.toString();

  // Convert cart items to JSON and add as a field
  request.fields['cart'] = jsonEncode(cart);

  // Send the request
  final response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final decodedResponse = jsonDecode(responseBody);

    if (decodedResponse['status'] == true) {
      print('Order placed successfully');
      return decodedResponse['order_id'];
    } else {
      print('----response${decodedResponse['status']}');
      print('Error in response: ${decodedResponse['message']}');
      return null;
    }
  } else {
    // Log detailed error information
    print('Failed to place order: ${response.statusCode}');
    print('Address ID: $addressId');
    print('Payment Method: $paymentMethod');
    print('Total Amount: $totalAmount');
    print('Quantity: $quantity');
    print('Cart: $cart');
    return null;
  }
}

// Future<String> paymentService({
//   required String token,
//   required String addressId,
//   required String paymentMethod,
//   required List<Map<String, dynamic>> cart,
//   required double totalAmount,
//   required double discount,
//   required String couponCode,
//   required double deliveryCharge,
//   required int quantity,
// }) async {
//   String url = '${baseUrl}/api/place-order';

//   // Create the MultipartRequest
//   var request = http.MultipartRequest('POST', Uri.parse(url));

//   // Add headers
//   request.headers.addAll({
//     'Authorization': 'Bearer $token',
//     'Content-Type': 'multipart/form-data',
//   });

//   // Add form fields
//   request.fields['address_id'] = addressId;
//   request.fields['payment_method'] = paymentMethod;
//   request.fields['total_amount'] = totalAmount.toString();
//   request.fields['discount'] = discount.toString();
//   request.fields['coupon_code'] = couponCode;
//   request.fields['delivery_charge'] = deliveryCharge.toString();
//   request.fields['quantity'] = quantity.toString();

//   // Convert cart items to JSON and add as a field
//   request.fields['cart'] = jsonEncode(cart);

//   // Send the request
//   final response = await request.send();

//   // Handle the response
//   if (response.statusCode == 200) {
//     print('Order placed successfully');
//     return 'success';
//   } else {
//     print(cart);
//     print(token);
//     print('Failed to place order: ${response.statusCode}');
//     print("address id ${addressId}");
//     print("pay meth ${paymentMethod}");
//     print("total amount ${totalAmount}");
//     print("quantity ${quantity}");
//     return 'error';
//   }
// }
