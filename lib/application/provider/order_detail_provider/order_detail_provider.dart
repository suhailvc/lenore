import 'package:flutter/material.dart';
import 'package:lenore/domain/order_detail_model/order_detail_model.dart';
import 'package:lenore/infrastructure/order_detail_api/order_detail_api.dart';

class OrderDetailProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  OrderDetailModel? orderDetail;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrderHistory(String token, String orderId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      orderDetail = await fetchOrderDetailService(token, orderId);
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
