import 'package:flutter/material.dart';

import 'package:lenore/domain/product_listing_model/product_listing_model.dart';
import 'package:lenore/infrastructure/bestseller_new_aarival_product_list_api/bestseller_new_aarival_product_list_provider.dart';

import 'package:lenore/infrastructure/product_listing_api/product_listing_api.dart';

class BestSellerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductListModel _productListItems = ProductListModel(data: []);
  ProductListModel get productListItems => _productListItems;

  Future<void> bestSellerProviderMethod(
      {required String pageNo,
      bool isPagination = false, // Flag to check if it’s a new page or refresh
      required String eventName,
      int? id}) async {
    _setLoading(true);
    try {
      var response =
          await bestSellerNewArrivalproductListService(pageNo, eventName, id);
      if (response != null) {
        if (isPagination) {
          // Append new data to the existing list
          _productListItems.data!.addAll(response.data!);
        } else {
          // Replace the data for the first page or on refresh
          _productListItems = response;
        }
      }
    } catch (error) {
      print("Error fetching product list: $error");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
