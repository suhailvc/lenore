import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/domain/country_model/country_model.dart';
import 'package:lenore/infrastructure/user_reigtraion_api/user_registration_api.dart';

import 'package:lenore/domain/user_registration_model/user_registration_data_taken.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;

class UserRegistrationProvider extends ChangeNotifier {
  bool _isLoading = false;
  ErrorDetails? errors;
  List<File> documents = [];

  // Added controllers
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController qIdController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // Added state variables
  String? selectedGender;
  // String? selectedCountry;
  bool termsAccepted = false;
  bool showTermsError = false;
  bool showErrors = false;
  List<String> genderOptions = ['Male', 'Female'];

  final ImagePicker _picker = ImagePicker();
  bool get isLoading => _isLoading;

  // Existing image picking method
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    if (documents.length >= 2) {
      customSnackBar(context, "Only two image is allowed");
      return;
    }
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      documents.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  // Existing document removal method
  void removeDocument(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  // Added methods for state management
  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  // void setCountry(Country country) {
  //   selectedCountry = country.name;
  //   countryController.text = country.name;
  //   notifyListeners();
  // }

  void setTermsAccepted(bool? value) {
    termsAccepted = value ?? false;
    showTermsError = !termsAccepted;
    notifyListeners();
  }

  void setShowErrors(bool value) {
    showErrors = value;
    notifyListeners();
  }

  void resetForm() {
    fNameController.clear();
    lNameController.clear();
    emailController.clear();
    qIdController.clear();
    countryController.clear();
    selectedGender = null;
    selectedCountryId = null;
    termsAccepted = false;
    showErrors = false;
    showTermsError = false;
    documents.clear();
    errors = null;
    notifyListeners();
  }

  bool validateForm() {
    showErrors = true;
    notifyListeners();

    return fNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        qIdController.text.isNotEmpty &&
        selectedGender != null &&
        selectedCountryId != null &&
        termsAccepted &&
        documents.isNotEmpty;
  }

  List<CountryModel> _countries = [];
  int? selectedCountryId;

  List<CountryModel> get countries => _countries;

  Future<void> fetchCountries() async {
    try {
      final response =
          await http.get(Uri.parse('https://lenore.qa/api/countries'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          _countries = (data['countries'] as List)
              .map((country) => CountryModel.fromJson(country))
              .toList();
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }

  void setSelectedCountry(int id, String name) {
    selectedCountryId = id;
    countryController.text = name;
    notifyListeners();
  }

  // Existing registration method updated to include country
  Future<dynamic> userRegistration({
    required context,
    required String fName,
    required String sName,
    required String email,
    required String qId,
    required String countryId, // Added country parameter
    required String gender,
    required bool term,
    required String mobileNumber,
    required List<File> documents,
  }) async {
    _isLoading = true;
    errors = null;
    notifyListeners();

    // if (fName.isEmpty || email.isEmpty || qId.isEmpty || gender.isEmpty
    //     //||
    //     //   country.isEmpty
    //     ) {
    //   errors = ErrorDetails(
    //     email: email.isEmpty ? ["Email is required"] : null,
    //     qId: qId.isEmpty ? ["QID is required"] : null,
    //     phone: mobileNumber.isEmpty ? ["Phone is required"] : null,
    //     // Added country validation
    //     //  country: country.isEmpty ? ["Country is required"] : null,
    //   );
    //   _isLoading = false;
    //   notifyListeners();
    //   return null;
    // }

    var response = await userRegistrationService(
      context: context,
      email: email,
      fName: fName,
      gender: gender,
      mobileNumber: mobileNumber,
      qId: qId,
      sName: sName,
      term: term,
      countryId: countryId, // Added country
      documents: documents,
    );

    if (response is UserRegistrationDataTakenModel) {
      errors = response.errors;
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    qIdController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
// class UserRegistrationProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   ErrorDetails? errors;
//   List<File> documents = [];

//   final ImagePicker _picker = ImagePicker();
//   bool get isLoading => _isLoading;
//   Future<void> pickImage(ImageSource source, BuildContext context) async {
//     if (documents.length >= 2) {
//       customSnackBar(context, "Only two image is allowed");
//       // Prevent picking more images if the limit is reached
//       return;
//     }
//     final XFile? pickedFile = await _picker.pickImage(source: source);

//     if (pickedFile != null) {
//       documents.add(File(pickedFile.path)); // Add the selected file to the list
//       notifyListeners();
//     }
//   }

//   void removeDocument(int index) {
//     documents.removeAt(index); // Remove a specific document from the list
//     notifyListeners();
//   }

//   Future<dynamic> userRegistration({
//     required context,
//     required String fName,
//     required String sName,
//     required String email,
//     required String qId,
//     required String gender,
//     required bool term,
//     required String mobileNumber,
//     required List<File> documents, // Add the images as a parameter
//   }) async {
//     _isLoading = true;
//     errors = null; // Clear any previous errors
//     notifyListeners();

//     if (fName.isEmpty || email.isEmpty || qId.isEmpty || gender.isEmpty) {
//       // Check for missing required fields
//       errors = ErrorDetails(
//         email: email.isEmpty ? ["Email is required"] : null,
//         qId: qId.isEmpty ? ["QID is required"] : null,
//         phone: mobileNumber.isEmpty ? ["Phone is required"] : null,
//       );
//       _isLoading = false;
//       notifyListeners();
//       return null;
//     }

//     var response = await userRegistrationService(
//       context: context,
//       email: email,
//       fName: fName,
//       gender: gender,
//       mobileNumber: mobileNumber,
//       qId: qId,
//       sName: sName,
//       term: term,
//       documents: documents, // Pass the images to the service
//     );

//     if (response is UserRegistrationDataTakenModel) {
//       errors = response.errors;
//     }

//     _isLoading = false;
//     notifyListeners();
//     return response;
//   }
// }
