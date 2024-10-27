import 'package:flutter/material.dart';
import 'package:lenore/domain/product_listing_model/product_listing_model.dart';
import 'package:lenore/infrastructure/product_listing_api/product_listing_api.dart';

class ProductListProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductListModel _productListItems = ProductListModel(data: []);
  ProductListModel get productListItems => _productListItems;

  Future<void> productListProviderMethod({
    required String eventName,
    required String pageNo,
    bool isPagination = false,
    int? id, // Flag to check if it’s a new page or refresh
  }) async {
    _setLoading(true);
    try {
      var response = await productListingService(pageNo, eventName, id);
      if (response != null) {
        if (isPagination) {
          // Append new data to the existing list
          _productListItems.data!.addAll(response.data!);
        } else {
          // Replace the data for the first page or on refresh
          _productListItems = response;
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (error) {
      print("Error fetching product list: $error");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
