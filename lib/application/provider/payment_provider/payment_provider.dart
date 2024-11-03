import 'package:flutter/material.dart';
import 'package:lenore/infrastructure/payment_api/payment_api.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? response;

  bool get isLoading => _isLoading;

  Future<String> placeOrder({
    required String token,
    required String addressId,
    required String paymentMethod,
    required List<Map<String, dynamic>> cart,
    required double totalAmount,
    required double discount,
    required String couponCode,
    required double deliveryCharge,
    required int quantity,
  }) async {
    _setLoading(true);

    try {
      response = await paymentService(
        token: token,
        addressId: addressId,
        paymentMethod: paymentMethod,
        cart: cart,
        totalAmount: totalAmount,
        discount: discount,
        couponCode: couponCode,
        deliveryCharge: deliveryCharge,
        quantity: quantity,
      );
      return response ?? 'error';
    } catch (error) {
      print('Error placing order: $error');
      return 'error';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
