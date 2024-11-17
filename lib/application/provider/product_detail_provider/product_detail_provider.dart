import 'package:flutter/material.dart';
import 'package:lenore/domain/product_detail_model/product_detail_model.dart';

import 'package:lenore/infrastructure/product_detail_api/product_detail_api.dart';

class ProductDetailProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  ProductDetailModel? _productDetails;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ProductDetailModel? get productDetails => _productDetails;

  Future<ProductDetailModel?> fetchProductDetails({
    required int id,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final response = await productDetailService(id);
      if (response != null) {
        _productDetails = response;
        return response;
      } else {
        _productDetails = null; // Set to null if there's no data
        _setError("No data available for this category");
        return null;
      }
    } catch (error) {
      _productDetails = null; // Clear data in case of error
      _setError("Error fetching subcategories: $error");
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
