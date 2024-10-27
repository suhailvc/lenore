import 'package:flutter/material.dart';
import 'package:lenore/infrastructure/user_reigtraion_api/user_registration_api.dart';

class UserRegistrationProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<dynamic> userRegistration(
      {required String fName,
      required String sName,
      required String email,
      required String qId,
      required String gender,
      required bool term,
      required String mobileNumber}) async {
    _isLoading = true;
    notifyListeners();

    var response = await userRegistrationService(
        email: email,
        fName: fName,
        gender: gender,
        mobileNumber: mobileNumber,
        qId: qId,
        sName: sName,
        term: term);
    notifyListeners();

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
