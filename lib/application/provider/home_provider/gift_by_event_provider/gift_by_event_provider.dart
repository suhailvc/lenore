import 'package:flutter/material.dart';
import 'package:lenore/domain/home_model/gift_by_event_model/gift_by_event_model.dart';
import 'package:lenore/infrastructure/home/gift_by_event_api/gift_by_event_api.dart';
import 'package:flutter/material.dart';
import 'package:lenore/domain/home_model/gift_by_event_model/gift_by_event_model.dart';
import 'package:lenore/infrastructure/home/gift_by_event_api/gift_by_event_api.dart';

class GiftByEventProvider with ChangeNotifier {
  bool _isLoading = false;
  GiftByEventModel? _cachedResponse;

  bool get isLoading => _isLoading;
  GiftByEventModel? get cachedResponse => _cachedResponse;

  Future<GiftByEventModel?> giftByEventProviderMethod() async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await giftByEventService();
      _cachedResponse = response;
      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}

// class GiftByEventProvider with ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<GiftByEventModel> giftByEventProviderMethod() async {
//     _isLoading = true;
//     notifyListeners();

//     var response = await giftByEventService();
//     notifyListeners();

//     _isLoading = false;
//     notifyListeners();
//     return response!;
//   }
// }
