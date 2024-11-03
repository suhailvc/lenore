import 'package:flutter/material.dart';
import 'package:lenore/domain/get_wishlist_model/get_wishlist_model.dart';
import 'package:lenore/infrastructure/add_to_wishlist_api/add_to_wishlist_api.dart';
import 'package:lenore/infrastructure/get_wishlist_api/get_wishlist_api.dart';
import 'package:flutter/material.dart';
import 'package:lenore/domain/get_wishlist_model/get_wishlist_model.dart';
import 'package:lenore/infrastructure/add_to_wishlist_api/add_to_wishlist_api.dart';
import 'package:lenore/infrastructure/get_wishlist_api/get_wishlist_api.dart';

class WishlistProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isFirstLoadCompleted = false; // Tracks if the first load is done
  String? _errorMessage;
  GetWishListModel? _wishlist;

  bool get isLoading => _isLoading;
  bool get isFirstLoadCompleted => _isFirstLoadCompleted;
  String? get errorMessage => _errorMessage;
  GetWishListModel? get wishlist => _wishlist;

  /// Fetch the entire wishlist
  Future<void> fetchWishlist(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _wishlist = await getWishListService(token);
      _isFirstLoadCompleted = true; // Mark the first load as complete
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch wishlist';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Check if a specific product is in the wishlist
  bool isProductInWishlist(int productId) {
    if (_wishlist == null || _wishlist!.data.isEmpty) return false;
    return _wishlist!.data.any((item) => item.id == productId);
  }

  /// Add or remove a product from the wishlist and refresh
  Future<void> toggleWishlist(String token, int productId) async {
    _isLoading = true;
    notifyListeners();

    bool addToWishlist = !isProductInWishlist(productId);
    final quantity = addToWishlist ? '1' : '0';

    try {
      final result = await addToWishListService(productId, quantity, token);
      if (result) {
        await fetchWishlist(token); // Refresh the wishlist after update
      } else {
        _errorMessage = 'Failed to update wishlist';
      }
    } catch (e) {
      _errorMessage = 'Error updating wishlist: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// class WishlistProvider with ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   GetWishListModel? _wishlist;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   GetWishListModel? get wishlist => _wishlist;

//   /// Fetch the entire wishlist
//   Future<void> fetchWishlist(String token) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _wishlist = await getWishListService(token);
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = 'Failed to fetch wishlist';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Check if a specific product is in the wishlist
//   bool isProductInWishlist(int productId) {
//     if (_wishlist == null || _wishlist!.data.isEmpty) return false;
//     return _wishlist!.data.any((item) => item.id == productId);
//   }

//   /// Add or remove a product from the wishlist and refresh
//   Future<void> toggleWishlist(String token, int productId) async {
//     _isLoading = true;
//     notifyListeners();

//     bool addToWishlist = !isProductInWishlist(productId);
//     final quantity = addToWishlist ? '1' : '0';

//     try {
//       final result = await addToWishListService(productId, quantity, token);
//       if (result) {
//         await fetchWishlist(token); // Refresh the wishlist after update
//       } else {
//         _errorMessage = 'Failed to update wishlist';
//       }
//     } catch (e) {
//       _errorMessage = 'Error updating wishlist: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }


// class WishlistProvider with ChangeNotifier {
//   bool _isInWishlist = false;
//   bool _isLoading = false;
//   String? _errorMessage;
//   GetWishListModel? _wishlist;

//   bool get isInWishlist => _isInWishlist;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   GetWishListModel? get wishlist => _wishlist;

//   /// Check if the product is in the wishlist by calling the API.
//   Future<void> checkProductInWishlist(String token, int productId) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _isInWishlist = await isProductInWishlist(token, productId);
//     } catch (e) {
//       _errorMessage = 'Failed to check wishlist status';
//       _isInWishlist = false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Fetch the entire wishlist
//   Future<void> fetchWishlist(String token) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _wishlist = await getWishListService(token);
//     } catch (e) {
//       _errorMessage = 'Failed to fetch wishlist';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Add or remove a product from the wishlist
//   Future<void> toggleWishlist(
//       String token, int productId, bool addToWishlist) async {
//     _isLoading = true;
//     notifyListeners();

//     final quantity = addToWishlist ? '1' : '0';
//     final result = await addToWishListService(productId, quantity, token);

//     if (result) {
//       _isInWishlist = addToWishlist;
//       await fetchWishlist(token); // Refresh the wishlist after update
//     } else {
//       _errorMessage = 'Failed to update wishlist';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
