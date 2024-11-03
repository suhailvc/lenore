import 'package:flutter/material.dart';
import 'package:lenore/infrastructure/coupon_api/coupon_api.dart';

class CouponProvider with ChangeNotifier {
  couponApiService _apiService = couponApiService();
  Map<String, dynamic>? couponData;

  Future<void> fetchCouponData(String couponCode) async {
    couponData = await _apiService.getCouponDiscount(couponCode);
    notifyListeners();
  }

  void clearCouponData() {
    couponData = null;
    notifyListeners();
  }
}
