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

  Future<void> editProfileRequest({
    required String fName,
    required String email,
    required String gender,
    String? lName,
  }) async {
    isLoading = true;
    responseMessage = "";
    errors = {};
    notifyListeners();

    final result = await editProfileService(
        fName: fName, email: email, gender: gender, image: selectedImage);

    if (result == 'success') {
      responseMessage = 'success';
    } else if (result == 'failed') {
      responseMessage = "failed";
    }

    isLoading = false;
    notifyListeners();
  }
}
