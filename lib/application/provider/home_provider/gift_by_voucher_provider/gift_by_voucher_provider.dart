import 'package:flutter/material.dart';

import 'package:lenore/domain/home_model/gift_by_voucher_model/gift_by_voucher_model.dart';

import 'package:lenore/infrastructure/home/gift_by_voucher_api/gift_by_voucher_api.dart';

class GiftByVoucherProvider with ChangeNotifier {
  bool _isLoading = false;
  GiftByVoucherModel? _giftByVoucherItems;

  bool get isLoading => _isLoading;
  GiftByVoucherModel? get giftByVoucherItems => _giftByVoucherItems;

  Future<void> fetchGiftByVoucherItems() async {
    _setLoading(true);
    try {
      var response = await giftByVoucherService();
      if (response != null) {
        _giftByVoucherItems = response;
      }
    } catch (error) {
      // Handle error here if necessary, e.g. set error state
      print("Error fetching best sellers: $error");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Only notify when loading state changes
  }
}
