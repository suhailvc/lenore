import 'package:flutter/material.dart';
import 'package:lenore/domain/voucher_detail_model/voucher_detail_model.dart';
import 'package:lenore/infrastructure/voucher_detail_api/voucher_detail_api.dart';

class VocherDetailProvider with ChangeNotifier {
  VoucherDetailModel? _voucherDetail;
  bool _isLoading = false;
  String? _errorMessage;

  VoucherDetailModel? get voucherDetail => _voucherDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchVoucherDetail(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final voucher = await vocherDetailApi(id);
      if (voucher != null) {
        _voucherDetail = voucher;
      } else {
        _errorMessage = "Failed to load voucher details.";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
