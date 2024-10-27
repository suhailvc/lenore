import 'package:flutter/material.dart';
import 'package:lenore/domain/home_model/collection_model/collection_model.dart';
import 'package:lenore/infrastructure/home/collection_api/collection_api.dart';

class CollectionProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  CollectionModel _collectionItems = CollectionModel();
  CollectionModel get collectionItems => _collectionItems;
  Future<void> collectionProviderMethod() async {
    _setLoading(true);
    try {
      var response = await collectionService();
      if (response != null) {
        _collectionItems = response;
      }
    } catch (error) {
      // Handle error here if necessary, e.g. set error state
      print("Error fetching best sellers: $error");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Only notify when loading state changes
  }
}
