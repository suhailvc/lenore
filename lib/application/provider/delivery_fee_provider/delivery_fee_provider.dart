import 'package:flutter/material.dart';
import 'package:lenore/domain/delivery_fee_model/delivery_fee_model.dart';
import 'package:lenore/infrastructure/delivery_fee_api/delivery_fee_api.dart';

class DeliveryFeeProvider extends ChangeNotifier {
  DeliveryFeeModel? _deliveryFee;
  bool _isLoading = false;

  DeliveryFeeModel? get deliveryFee => _deliveryFee;
  bool get isLoading => _isLoading;

  Future<void> fetchDeliveryFee() async {
    _isLoading = true;
    notifyListeners();

    try {
      _deliveryFee = await deliveryFeeApi();
    } catch (e) {
      print('Error fetching delivery fee: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
