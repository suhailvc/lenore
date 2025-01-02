import 'package:flutter/material.dart';
import 'package:lenore/domain/filter_model/filter_model.dart';
import 'package:lenore/infrastructure/filter_api/filter_api.dart';
import 'package:lenore/presentation/screens/best_seller_new_arrival_listing_screen/widget/constants.dart';

class FilterProvider with ChangeNotifier {
  int? _categoryId;
  List<int> _selectedSubCategoryIds = [];
  List<int> _selectedEventIds = [];
  List<int> _selectedCollectionIds = [];
  List<int> _selectedGoldPurities = [];
  // FilterModel? filterResults;
  bool isLoading = false;
  String? errorMessage;

  int? get categoryId => _categoryId;
  List<int> get selectedSubCategoryIds => _selectedSubCategoryIds;
  List<int> get selectedEventIds => _selectedEventIds;
  List<int> get selectedCollectionIds => _selectedCollectionIds;
  List<int> get selectedGoldPurities => _selectedGoldPurities;

  void updateCategoryId(int? id) {
    _categoryId = id;
    notifyListeners();
  }

  void updateSubCategoryIds(List<int> ids) {
    _selectedSubCategoryIds = ids;
    notifyListeners();
  }

  void updateEventIds(List<int> ids) {
    _selectedEventIds = ids;
    notifyListeners();
  }

  void updateCollectionIds(List<int> ids) {
    _selectedCollectionIds = ids;
    notifyListeners();
  }

  void updateGoldPurities(List<int> purities) {
    _selectedGoldPurities = purities;
    notifyListeners();
  }

  Future<void> fetchFilteredProducts({
    String? categoryId,
    List<int>? subcategoryId,
    List<int>? eventId,
    List<int>? collectionId,
    List<int>? gold,
    // required String token,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      //filterResults
      newAllrivalList = await filterApiService(
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        eventId: eventId,
        collectionId: collectionId,
        gold: gold,
        //  token: token,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetFilters() {
    _categoryId = null;
    _selectedSubCategoryIds = [];
    _selectedEventIds = [];
    _selectedCollectionIds = [];
    _selectedGoldPurities = [];
    notifyListeners();
  }
}


// class FilterProvider with ChangeNotifier {
//   int? _categoryId;
//   final FilterApiService _apiService = FilterApiService();
//   FilterModel? filterResults;
//   bool isLoading = false;
//   String? errorMessage;
//   int? get categoryId => _categoryId;

//   void updateCategoryId(int id) {
//     _categoryId = id;
//     notifyListeners();
//   }

//   Future<void> fetchFilteredProducts({
//     String? categoryId,
//     List<int>? subcategoryId,
//     List<int>? eventId,
//     List<int>? collectionId,
//     List<int>? gold,
//     required String token,
//   }) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       filterResults = await _apiService.filterApiService(
//         categoryId: categoryId,
//         subcategoryId: subcategoryId,
//         eventId: eventId,
//         collectionId: collectionId,
//         gold: gold,
//         token: token,
//       );
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
