import 'package:flutter/material.dart';
import 'package:lenore/domain/home_model/gift_by_category/giftByCategoryModel.dart';
import 'package:lenore/infrastructure/home/gift_by_category/gift_by_category_api.dart';

// class GiftByCategoryProvider with ChangeNotifier {
//   bool _isLoading = false;
//   GiftByCategoryModel?
//       _cachedResponse; // Cached response to avoid multiple API calls
//   DateTime? _lastFetchTime; // To keep track of the last fetch time

//   bool get isLoading => _isLoading;

//   GiftByCategoryModel? get cachedResponse => _cachedResponse;

//   // Add a 'forceRefresh' parameter to control when to bypass the cache
//   Future<GiftByCategoryModel?> giftByCategoryProviderMethod(
//       {bool forceRefresh = false}) async {
//     // Check if we need to refresh the cache (either forced or expired)
//     if (_cachedResponse != null && !forceRefresh) {
//       // Optional: Add a cache expiration policy (e.g., every 10 minutes)
//       if (_lastFetchTime != null &&
//           DateTime.now().difference(_lastFetchTime!).inMinutes < 10) {
//         return _cachedResponse; // Return cached data if it’s still valid
//       }
//     }

//     _isLoading = true;
//     notifyListeners(); // Notify that loading has started

//     try {
//       var response = await giftByCategoryService();

//       // Cache the response and record the fetch time
//       _cachedResponse = response;
//       _lastFetchTime = DateTime.now();

//       _isLoading = false;
//       notifyListeners(); // Notify listeners that loading is complete
//       return response;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return null;
//     }
//   }
// }

class GiftByCategoryProvider with ChangeNotifier {
  bool _isLoading = false;
  GiftByCategoryModel?
      _cachedResponse; // Cached response to avoid multiple API calls

  bool get isLoading => _isLoading;

  // Getter for the cached response
  GiftByCategoryModel? get cachedResponse => _cachedResponse;

  Future<GiftByCategoryModel?> giftByCategoryProviderMethod() async {
    if (_cachedResponse != null) {
      // Return cached data if available
      return _cachedResponse;
    }

    _isLoading = true;
    notifyListeners(); // Notify that loading has started

    try {
      var response = await giftByCategoryService();

      // Cache the response to avoid hitting the API frequently
      _cachedResponse = response;

      _isLoading = false;
      notifyListeners(); // Notify listeners that loading is complete
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}


//class GiftByCategoryProvider with ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<GiftByCategoryModel> giftByCategoryProviderMethod() async {
//     _isLoading = true;
//     notifyListeners();

//     var response = await giftByCategoryService();
//     notifyListeners();

//     _isLoading = false;
//     notifyListeners();
//     return response!;
//   }
// }
