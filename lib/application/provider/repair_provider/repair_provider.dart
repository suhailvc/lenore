import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/domain/customization_model/error_response_model.dart';
import 'package:lenore/domain/customization_model/success_model.dart';
import 'dart:io';
import 'package:lenore/infrastructure/customization_api/customization_api.dart';
import 'package:lenore/infrastructure/repair_api/repair_api.dart';

class RepairProvider with ChangeNotifier {
  bool isLoading = false;
  String responseMessage = "";
  Map<String, List<String>> errors = {};
  List<File> selectedImages = []; // List to hold multiple images

  // Function to pick an image from either gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImages.add(File(image.path)); // Add each image to the list
      notifyListeners();
    }
  }

  Future<void> sendRepairRequest(
      {required String name,
      required String phone,
      required String type,
      required String weight,
      required String purity,
      required String productType,
      required String message,
      required String filterType}) async {
    isLoading = true;
    responseMessage = "";
    errors = {};
    notifyListeners();

    final result = await submitRepairRequest(
      filterType: filterType,
      name: name,
      phone: phone,
      type: type,
      weight: weight,
      purity: purity,
      productType: productType,
      message: message,
      images: selectedImages, // Pass the list of images
    );

    if (result is CustomizationSuccessResponse) {
      responseMessage = result.message;
      clearImages(); // Clear images after successful submission
    } else if (result is CustomizationErrorResponse) {
      errors = result.errors;
      responseMessage = "Submission failed. Check errors.";
    }

    isLoading = false;
    notifyListeners();
  }

  // Clear images after submission
  void clearImages() {
    selectedImages.clear();
    notifyListeners();
  }
}
