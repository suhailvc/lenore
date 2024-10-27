// api_service.dart

import 'package:flutter/foundation.dart';
import 'package:lenore/domain/mobile_number_model/mobile_number_model.dart';
import 'package:lenore/infrastructure/mobile_number_api/mobile_number_api.dart';

class MobileNumberProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _resultMessage;

  bool get isLoading => _isLoading;
  String? get resultMessage => _resultMessage;

  // Function to call the sendMobileNumber from the service class
  Future<void> sendMobileNumber(String phoneNumber) async {
    _isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      MobileNumberModel? response = await sendMobileNumberService(phoneNumber);

      if (response != null && response.status == true) {
        _resultMessage = response.message ?? 'Success';
      } else {
        _resultMessage = response?.message ?? 'Failed to send mobile number';
      }
    } catch (e) {
      _resultMessage = 'Exception: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
