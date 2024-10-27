import 'package:flutter/material.dart';
import 'package:lenore/domain/sub_category_model/sub_category_model.dart';
import 'package:lenore/infrastructure/sub_category_api/sub_category_api.dart';

class SubCategoryProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  SubCategoryModel? _subCategoryItems;

  bool get isLoading => _isLoading;
  String? get error => _error;
  SubCategoryModel? get subCategoryItems => _subCategoryItems;

  Future<void> fetchSubCategoriesItems({
    required String categoryName,
    required String id,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final response = await subCategoryService(categoryName, id);
      if (response != null) {
        _subCategoryItems = response;
      } else {
        _subCategoryItems = null; // Set to null if there's no data
        _setError("No data available for this category");
      }
    } catch (error) {
      _subCategoryItems = null; // Clear data in case of error
      _setError("Error fetching subcategories: $error");
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
