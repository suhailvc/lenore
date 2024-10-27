import 'package:flutter/material.dart';

import 'package:lenore/domain/home_model/gift_by_voucher_model/gift_by_voucher_model.dart';
import 'package:lenore/domain/home_model/home_banner_model/home_banner_model.dart';

import 'package:lenore/infrastructure/home/gift_by_voucher_api/gift_by_voucher_api.dart';
import 'package:lenore/infrastructure/home/home_banner_api/home_banner_api.dart';

class HomeBannerProvider with ChangeNotifier {
  bool _isLoading = false;
  HomeBannerModel _homeBannerItems = HomeBannerModel();

  bool get isLoading => _isLoading;
  HomeBannerModel get giftByVoucherItems => _homeBannerItems;

  Future<void> fetchHomeBannerItems() async {
    _setLoading(true);
    try {
      var response = await HomeBannerService();
      if (response != null) {
        _homeBannerItems = response;
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
