import 'package:flutter/material.dart';
import 'package:lenore/domain/get_wishlist_model/get_wishlist_model.dart';
import 'package:lenore/infrastructure/get_wishlist_api/get_wishlist_api.dart';

class GetWishListProvider extends ChangeNotifier {
  GetWishListModel? _wishlist;
  bool _isLoading = false;

  GetWishListModel? get wishlist => _wishlist;
  bool get isLoading => _isLoading;

  Future<void> fetchWishlist(String token) async {
    _isLoading = true;
    notifyListeners();

    _wishlist = await getWishListService(token);

    _isLoading = false;
    notifyListeners();
  }

  bool isProductInWishlist(int productId) {
    if (_wishlist == null || _wishlist!.data.isEmpty) return false;
    bool result = _wishlist!.data.any((item) => item.id == productId);
    notifyListeners();
    return result;
  }
}
