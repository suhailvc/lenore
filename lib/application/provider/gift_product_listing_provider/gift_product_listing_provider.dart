import 'package:flutter/material.dart';

import 'package:lenore/domain/product_listing_model/product_listing_model.dart';

import 'package:lenore/infrastructure/gift_product_listing_api/gift_product_listing_api.dart';

class GiftProductListingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductListModel _productListItems = ProductListModel(data: []);
  ProductListModel get productListItems => _productListItems;

  Future<void> productListProviderMethod({
    required String eventId,
    required String pageNo,
    bool isPagination = false, // Flag to check if it’s a new page or refresh
  }) async {
    _setLoading(true);
    try {
      var response = await giftProductListService(eventId, pageNo);
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

// class ProductListProvider extends ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;
//   ProductListModel _productListItems = ProductListModel();
//   ProductListModel get productListItems => _productListItems;
//   Future<void> productListProviderMethod(
//       {required String eventId, required String pageNo}) async {
//     _setLoading(true);
//     try {
//       var response = await ProductListService(eventId, pageNo);
//       if (response != null) {
//         _productListItems = response;
//       }
//     } catch (error) {
//       // Handle error here if necessary, e.g. set error state
//       print("Error fetching best sellers: $error");
//     } finally {
//       _setLoading(false);
//     }
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// }
