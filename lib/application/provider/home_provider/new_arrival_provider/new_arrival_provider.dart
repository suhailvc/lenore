// import 'package:flutter/material.dart';
// import 'package:lenore/domain/home_model/best_seller_model/best_seller_model.dart';
// import 'package:lenore/domain/home_model/new_arrival_model/new_arrival_model.dart';
// import 'package:lenore/infrastructure/home/best_seller_api/best_seller_api.dart';
// import 'package:lenore/infrastructure/home/new_arrival_api/new_arrival_api.dart';

// class NewArrivalProvider with ChangeNotifier {
//   bool _isLoading = false;
//   NewArrivalModel _newArrivalItems = NewArrivalModel();

//   bool get isLoading => _isLoading;
//   NewArrivalModel get newArrivalitems => _newArrivalItems;

//   Future<void> fetchNewArrivalItems() async {
//     _setLoading(true);
//     try {
//       var response = await newArrivalService();
//       if (response != null) {
//         _newArrivalItems = response;
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
//     notifyListeners(); // Only notify when loading state changes
//   }
// }
