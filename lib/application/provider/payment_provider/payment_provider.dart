import 'package:flutter/material.dart';
import 'package:lenore/infrastructure/payment_api/my_fatoorah_api.dart';
import 'package:lenore/infrastructure/payment_api/payment_api.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  int? response;

  bool get isLoading => _isLoading;
  // New method to update order status using invoiceIdService
  Future<Map<String, dynamic>> updateOrderStatus({
    required String token,
    required String orderId,
    required String invoiceId,
  }) async {
    _setLoading(true);

    try {
      var response = await invoiceIdService(
        orderId: orderId,
        invoiceId: invoiceId,
        token: token,
      );

      // Handle success/failure
      if (response['status'] == 'success') {
        print('Order status updated successfully');
      } else {
        print('Failed to update order status: ${response['message']}');
      }
      return response;
    } catch (error) {
      print('Error updating order status: $error');
      return {'status': 'error', 'message': 'Something went wrong'};
    } finally {
      _setLoading(false);
    }
  }

  Future<int?> placeOrder({
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
      return response;
    } catch (error) {
      print('Error placing order: $error');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
