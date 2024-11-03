import 'package:flutter/material.dart';

import 'package:lenore/infrastructure/otp_api/otp_api.dart';

class OtpProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Function to call the OTP verification service
  Future<dynamic> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    var response = await OtpApiService().verifyOtp(phoneNumber, otp, context);
    notifyListeners();

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
