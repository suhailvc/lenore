import 'package:flutter/material.dart';
import 'package:lenore/domain/check_out_model/check_out_model.dart';
import 'package:lenore/domain/check_out_model/svae_address_response.dart';
import 'package:lenore/infrastructure/check_out_api/check_out_api.dart';

// class CheckOutProvider with ChangeNotifier {
//   final CheckOutService _checkOutService = CheckOutService();
//   bool isLoading = false;
//   String statusMessage = '';
//   SaveAddressResponse? response;

//   // Method for saving address when the user selects "For Myself"
//   Future<void> saveAddressForMyself({
//     required String myName,
//     required String myPhone,
//   }) async {
//     isLoading = true;
//     notifyListeners();

//     final checkOutModel = CheckOutModel(
//       orderType: 'myself',
//       myName: myName,
//       myPhone: myPhone,
//       gifteeName: '',
//       gifteePhone: '',
//       to: '',
//       message: '',
//       date: '',
//       makeAnonymous: 0,
//       deliveryType: 'today',
//     );

//     try {
//       response = await _checkOutService.saveAddress(checkOutModel);
//       statusMessage = response!.message;
//     } catch (e) {
//       statusMessage = 'Failed to save address';
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // Method for saving address when the user selects "Send As Gift"
//   Future<void> saveAddressForGift({
//     required String gifteeName,
//     required String gifteePhone,
//     required String to,
//     required String message,
//     required String date,
//   }) async {
//     isLoading = true;
//     notifyListeners();

//     final checkOutModel = CheckOutModel(
//       orderType: 'gift',
//       myName: '',
//       myPhone: '',
//       gifteeName: gifteeName,
//       gifteePhone: gifteePhone,
//       to: to,
//       message: message,
//       date: date,
//       makeAnonymous: 1,
//       deliveryType: 'today',
//     );

//     try {
//       response = await _checkOutService.saveAddress(checkOutModel);
//       statusMessage = response!.message;
//     } catch (e) {
//       statusMessage = 'Failed to save address';
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }

class CheckOutProvider with ChangeNotifier {
  final CheckOutService _checkOutService = CheckOutService();
  bool isLoading = false;
  String statusMessage = '';
  int? addressId;
  SaveAddressResponse? response;
  CheckOutModel? list;

  Future<SaveAddressResponse?> saveAddress(
      CheckOutModel checkOutModel, String token) async {
    isLoading = true;
    statusMessage = '';
    notifyListeners();

    try {
      list = checkOutModel;
      response = await _checkOutService.saveAddress(checkOutModel, token);

      if (response!.status) {
        statusMessage = response!.message;
        addressId = response!.addressId;
        return response;
      } else {
        statusMessage = 'Failed to save address';
        return null;
      }
    } catch (e) {
      statusMessage = 'Error: ${e.toString()}';
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

class CheckBoxProvider extends ChangeNotifier {
  // bool _isChecked = false;
  bool _giftMySelfChecked = true;
  bool _sendAsGiftChecked = false;
  bool get giftMySelfChecked => _giftMySelfChecked;
  bool get sendAsGift => _sendAsGiftChecked;

  void toggleSendAsGift() {
    _sendAsGiftChecked = !_sendAsGiftChecked;
    _giftMySelfChecked = !_giftMySelfChecked;
    notifyListeners();
  }

  void toggleMySelf() {
    _sendAsGiftChecked = false;
    _giftMySelfChecked = true;
    notifyListeners();
  }
}
