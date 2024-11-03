import 'package:flutter/material.dart';
import 'package:lenore/domain/order_history_model/order_history_model.dart';
import 'package:lenore/infrastructure/order_history_api/order_history_api.dart';

class OrderHistoryProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  OrderHistoryModel? orderitems;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrderHistory(String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      orderitems = await fetchOrderHistoryService(token);
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
