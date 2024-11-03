import 'package:flutter/material.dart';
import 'package:lenore/domain/search_model/search_model.dart';
import 'package:lenore/infrastructure/search_api/search_api.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchData> searchList = [];
  bool isLoading = false;

  Future<void> fetchSearchResults(String key) async {
    isLoading = true;
    notifyListeners(); // Notify listeners to show loading state

    final SearchModel? searchResults = await searchService(key);

    if (searchResults != null && searchResults.data.isNotEmpty) {
      searchList = searchResults.data;
    } else {
      searchList = []; // Clear the list if no data found or in case of error
    }

    isLoading = false;
    notifyListeners(); // Notify listeners to update UI after data fetch
  }
}
