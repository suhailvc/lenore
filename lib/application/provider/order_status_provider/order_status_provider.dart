import 'package:flutter/material.dart';
import 'package:lenore/domain/order_status_model/order_status_model.dart';
import 'package:lenore/infrastructure/order_status_api/order_status_api.dart';

class OrderStatusProvider with ChangeNotifier {
  bool _isLoading = false;
  OrderStatusModel? _orderStatus;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  OrderStatusModel? get orderStatus => _orderStatus;
  String? get errorMessage => _errorMessage;

  final OrderStatusService _orderStatusService = OrderStatusService();

  Future<void> fetchOrderStatus(String orderId, String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result =
          await _orderStatusService.orderStatusService(orderId, token);
      _orderStatus = result;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
