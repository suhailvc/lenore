import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/infrastructure/user_reigtraion_api/user_registration_api.dart';

import 'package:lenore/domain/user_registration_model/user_registration_data_taken.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';

class UserRegistrationProvider extends ChangeNotifier {
  bool _isLoading = false;
  ErrorDetails? errors;
  List<File> documents = [];

  final ImagePicker _picker = ImagePicker();
  bool get isLoading => _isLoading;
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    if (documents.length >= 2) {
      customSnackBar(context, "Only two image is allowed");
      // Prevent picking more images if the limit is reached
      return;
    }
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      documents.add(File(pickedFile.path)); // Add the selected file to the list
      notifyListeners();
    }
  }

  void removeDocument(int index) {
    documents.removeAt(index); // Remove a specific document from the list
    notifyListeners();
  }

  Future<dynamic> userRegistration({
    required context,
    required String fName,
    required String sName,
    required String email,
    required String qId,
    required String gender,
    required bool term,
    required String mobileNumber,
    required List<File> documents, // Add the images as a parameter
  }) async {
    _isLoading = true;
    errors = null; // Clear any previous errors
    notifyListeners();

    if (fName.isEmpty || email.isEmpty || qId.isEmpty || gender.isEmpty) {
      // Check for missing required fields
      errors = ErrorDetails(
        email: email.isEmpty ? ["Email is required"] : null,
        qId: qId.isEmpty ? ["QID is required"] : null,
        phone: mobileNumber.isEmpty ? ["Phone is required"] : null,
      );
      _isLoading = false;
      notifyListeners();
      return null;
    }

    var response = await userRegistrationService(
      context: context,
      email: email,
      fName: fName,
      gender: gender,
      mobileNumber: mobileNumber,
      qId: qId,
      sName: sName,
      term: term,
      documents: documents, // Pass the images to the service
    );

    if (response is UserRegistrationDataTakenModel) {
      errors = response.errors;
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  // Future<dynamic> userRegistration({
  //   required context,
  //   required String fName,
  //   required String sName,
  //   required String email,
  //   required String qId,
  //   required String gender,
  //   required bool term,
  //   required String mobileNumber,
  // }) async {
  //   _isLoading = true;
  //   errors = null; // Clear any previous errors
  //   notifyListeners();

  //   if (fName.isEmpty || email.isEmpty || qId.isEmpty || gender.isEmpty) {
  //     // Check for missing required fields
  //     errors = ErrorDetails(
  //       email: email.isEmpty ? ["Email is required"] : null,
  //       qId: qId.isEmpty ? ["QID is required"] : null,
  //       phone: mobileNumber.isEmpty ? ["Phone is required"] : null,
  //     );
  //     _isLoading = false;
  //     notifyListeners();
  //     return null;
  //   }

  //   var response = await userRegistrationService(
  //     context: context,
  //     email: email,
  //     fName: fName,
  //     gender: gender,
  //     mobileNumber: mobileNumber,
  //     qId: qId,
  //     sName: sName,
  //     term: term,
  //   );

  //   if (response is UserRegistrationDataTakenModel) {
  //     errors = response.errors;
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  //   return response;
  // }
}

// class UserRegistrationProvider extends ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;
//   Future<dynamic> userRegistration(
//       {required String fName,
//       required String sName,
//       required String email,
//       required String qId,
//       required String gender,
//       required bool term,
//       required String mobileNumber}) async {
//     _isLoading = true;
//     notifyListeners();

//     var response = await userRegistrationService(
//         email: email,
//         fName: fName,
//         gender: gender,
//         mobileNumber: mobileNumber,
//         qId: qId,
//         sName: sName,
//         term: term);
//     notifyListeners();

//     _isLoading = false;
//     notifyListeners();
//     return response;
//   }
// }
