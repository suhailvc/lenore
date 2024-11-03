import 'package:flutter/material.dart';

import 'package:lenore/infrastructure/add_to_wishlist_api/add_to_wishlist_api.dart';

// class AddToWishlistProvider with ChangeNotifier {
//   bool _isLoading = false;
//   List<int> wishlistProductIds = [];

//   bool get isLoading => _isLoading;

//   Future<bool> addToWishListProvider(
//       int productId, String quantity, String token) async {
//     _isLoading = true;
//     notifyListeners();

//     final result = await addToWishListService(productId, quantity, token);

//     if (result) {
//       if (quantity == '1') {
//         wishlistProductIds.add(productId); // Add product to wishlist
//       } else {
//         wishlistProductIds.remove(productId); // Remove product from wishlist
//       }
//       notifyListeners(); // Notify UI of state change
//     }

//     _isLoading = false;
//     notifyListeners();

//     return result;
//   }

//   void updateWishlistProductIds(List<int> productIds) {
//     wishlistProductIds = productIds;
//     notifyListeners();
//   }

//   bool isProductInWishlist(int productId) {
//     return wishlistProductIds.contains(productId);
//   }
// }

class AddToWishlistProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> addToWishListProvider(
      int productId, String quantity, String token) async {
    _isLoading = true;
    notifyListeners();

    final result = await addToWishListService(productId, quantity, token);
    notifyListeners();
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
