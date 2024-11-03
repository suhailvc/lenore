import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:lenore/infrastructure/edit_profile_api/edit_profile_api.dart';

class EditProfileProvider with ChangeNotifier {
  bool isLoading = false;
  String responseMessage = "";
  Map<String, List<String>> errors = {};
  File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImage = File(image.path); // Store single image
      notifyListeners();
    }
  }

  Future<bool> editProfileRequest({
    required String fName,
    required String email,
    required String gender,
    String? lName,
    required String token,
  }) async {
    isLoading = true;
    responseMessage = "";
    errors = {};
    notifyListeners();

    final result = await editProfileService(
      lName: lName,
      fName: fName,
      email: email,
      gender: gender,
      image: selectedImage,
      token: token,
    );
    print('tapped');
    print(result);
    isLoading = false;
    responseMessage = result;
    notifyListeners();

    return result == 'Success'; // Return true if successful, otherwise false
  }
}

// class EditProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   String responseMessage = "";
//   Map<String, List<String>> errors = {};
//   File? selectedImage;

//   Future<void> pickImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: source);

//     if (image != null) {
//       selectedImage = File(image.path); // Store single image
//       notifyListeners();
//     }
//   }

//   Future<void> editProfileRequest({
//     required String fName,
//     required String email,
//     required String gender,
//     String? lName,
//     required String token,
//   }) async {
//     isLoading = true;
//     responseMessage = "";
//     errors = {};
//     notifyListeners();

//     final result = await editProfileService(
//       lName: lName,
//       fName: fName,
//       email: email,
//       gender: gender,
//       image: selectedImage,
//       token: token,
//     );

//     responseMessage = result == 'Success' ? 'Success' : 'Failed';
//     isLoading = false;
//     notifyListeners();
//   }
// }

// class EditProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   String responseMessage = "";
//   Map<String, List<String>> errors = {};
//   File? selectedImage;
//   Future<void> pickImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: source);

//     if (image != null) {
//       selectedImage = File(image.path); // Store single image
//       notifyListeners();
//     }
//   }

//   Future<void> editProfileRequest({
//     required String fName,
//     required String email,
//     required String gender,
//     required String token,
//     String? lName,
//   }) async {
//     isLoading = true;
//     responseMessage = "";
//     errors = {};
//     notifyListeners();

//     final result = await editProfileService(
//         token: token,
//         lName: lName,
//         fName: fName,
//         email: email,
//         gender: gender,
//         image: selectedImage);

//     if (result == 'success') {
//       responseMessage = 'success';
//     } else if (result == 'failed') {
//       responseMessage = "failed";
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }
