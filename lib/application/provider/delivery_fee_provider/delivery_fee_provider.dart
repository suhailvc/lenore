import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/delivery_charge_model/delivery_charge_model.dart';
import 'package:lenore/domain/delivery_fee_model/delivery_fee_model.dart';
import 'package:lenore/infrastructure/delivery_charge_api/delivery_charge_api.dart';
import 'package:lenore/infrastructure/delivery_fee_api/delivery_fee_api.dart';

class DeliveryFeeProvider extends ChangeNotifier {
  DeliveryFeeModel? _deliveryFee;
  bool _isLoading = false;

  DeliveryFeeModel? get deliveryFee => _deliveryFee;
  bool get isLoading => _isLoading;
  bool _isLoading1 = false;
  String? _error;
  double _deliveryCharge = 0.0;

  // Getters
  bool get isLoading1 => _isLoading1;
  String? get error => _error;
  double get deliveryCharge => _deliveryCharge;

  // Method to fetch delivery charge
  Future<double> fetchDeliveryCharge(
      List<DeliveryChargeRequestProduct> products) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await deliveryChargeApi(products);

      if (response != null && response.status) {
        _deliveryCharge = response.deliveryCharge;
        notifyListeners();
        return _deliveryCharge;
      } else {
        _setError(
            "Failed to get delivery charge: ${response?.message ?? 'Unknown error'}");
        return 0.0;
      }
    } catch (e) {
      _setError("Exception occurred: $e");
      return 0.0;
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading1 = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  Future<String> fetchDeliveryFee() async {
    _isLoading = true;
    notifyListeners();

    try {
      _deliveryFee = await deliveryFeeApi();
      globalDeliveryFee = _deliveryFee!.data.value;
      return _deliveryFee!.data.value;
    } catch (e) {
      print('Error fetching delivery fee: $e');
      return '0';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
