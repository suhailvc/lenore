import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/user_registration_model/user_registration_success_model.dart';
import 'package:lenore/presentation/screens/login_screen/personal_details_screen/widgets/qid_image_picker_widget.dart';

import 'package:lenore/presentation/screens/login_screen/personal_details_screen/widgets/user_input_field.dart';
import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';

import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final String mobileNumber;
  const PersonalDetailsScreen({required this.mobileNumber, super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserRegistrationProvider>(context, listen: false)
        .fetchCountries();
    Provider.of<UserRegistrationProvider>(context, listen: false).resetForm();
    Provider.of<UserRegistrationProvider>(context, listen: false)
        .documents
        .clear();
  }

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qIdController = TextEditingController();
  String? selectedGender;
  bool termsAccepted = false;
  bool showTermsError = false;
  bool showErrors = false; // New variable to control error display

  List<String> genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<UserRegistrationProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: querySize.height * 0.05),
                    const Text(
                      'Welcome to Lenore',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lora'),
                    ),
                    SizedBox(height: querySize.height * 0.01),
                    const Text(
                      'Enter Your Personal Details',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lora'),
                    ),
                    SizedBox(height: querySize.height * 0.02),

                    // First Name Field
                    userInputField(
                      context,
                      "assets/images/profile.png",
                      "Enter Your First Name",
                      "First Name",
                      fNameController,
                    ),
                    if (showErrors && fNameController.text.isEmpty)
                      errorText("First name is required"),
                    SizedBox(height: querySize.height * 0.03),

                    // Last Name Field
                    userInputField(
                      context,
                      "assets/images/profile.png",
                      "Enter Your Last Name",
                      "Last Name",
                      lNameController,
                    ),
                    SizedBox(height: querySize.height * 0.03),

                    // Email Field
                    userInputField(
                      context,
                      "assets/images/email.png",
                      "Enter Your Email",
                      "Email",
                      emailController,
                    ),
                    if (showErrors && provider.errors?.email != null)
                      errorText(provider.errors!.email!.first),
                    SizedBox(height: querySize.height * 0.03),

                    // QID Field
                    userInputField(
                      context,
                      "assets/images/flag_qatar.png",
                      "QID No",
                      "QID/ Passport",
                      qIdController,
                    ),
                    if (showErrors && provider.errors?.qId != null)
                      errorText(provider.errors!.qId!.first),
                    SizedBox(height: querySize.height * 0.03),
                    // Image Picker Section
                    // Image Picker Section with Bottom Sheet
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload QID Documents",
                          style: TextStyle(
                            fontFamily: 'Jost',
                            color: appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: querySize.height * 0.01),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(appColor)),
                          onPressed: () =>
                              showImagePickerBottomSheet(provider, context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: querySize.width * 0.02,
                              ),
                              const Text(
                                "Upload",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: querySize.height * 0.01),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: provider.documents.map((image) {
                            int index = provider.documents.indexOf(image);
                            return Stack(
                              children: [
                                Image.file(
                                  image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      provider.removeDocument(index);
                                    },
                                    icon: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    if (showErrors && provider.documents.isEmpty)
                      errorText("Image is required"),
                    SizedBox(height: querySize.height * 0.03),

                    countryInputField(context, provider),
                    if (showErrors && provider.selectedCountryId == null)
                      errorText("Country is required"),
                    SizedBox(height: querySize.height * 0.03),
                    // Gender Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontFamily: 'Jost',
                            color: appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: querySize.height * 0.01),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: querySize.height * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF00ACB3), width: 1.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedGender,
                                    hint: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              querySize.height * 0.001),
                                          child: Image.asset(
                                            "assets/images/profile.png",
                                            width: querySize.width * 0.08,
                                            height: querySize.height * 0.04,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Choose Gender',
                                          style: TextStyle(
                                              color: Color(0xFFD0D0D0)),
                                        ),
                                      ],
                                    ),
                                    icon: Image.asset(
                                      "assets/images/down_arrow.png",
                                      width: querySize.width * 0.08,
                                      height: querySize.height * 0.04,
                                    ),
                                    dropdownColor: Colors.white,
                                    menuMaxHeight: querySize.height * 0.2,
                                    items: genderOptions.map((String gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender == 'Male' ? '1' : '2',
                                        child: Text(gender),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedGender = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (showErrors && selectedGender == null)
                          errorText("Gender is required"),
                      ],
                    ),
                    SizedBox(height: querySize.height * 0.02),

                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              termsAccepted = value ?? false;
                              showTermsError = !termsAccepted;
                            });
                          },
                        ),
                        Text(
                          "I have read and agree to terms and conditions",
                          style: TextStyle(
                            fontSize: querySize.width * 0.031,
                            color: appColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Segoe',
                          ),
                        )
                      ],
                    ),
                    if (showErrors && showTermsError)
                      errorText("You must agree to the terms and conditions"),

                    customSizedBox(querySize),
                    Text(
                      "Note : Our team will contact you to confirm the ID number / Passport number",
                      style: TextStyle(
                        fontSize: querySize.width * 0.031,
                        color: const Color(0xFF7F7F7F),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Segoe',
                      ),
                    ),
                    SizedBox(height: querySize.height * 0.05),

                    // Continue Button
                    provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : loginCustomButton(context, querySize, "CONTINUE",
                            () async {
                            setState(() => showErrors = true); // Show errors
                            if (!termsAccepted) {
                              setState(() => showTermsError = true);
                              return;
                            }
                            var response = await provider.userRegistration(
                              countryId: provider.selectedCountryId.toString(),
                              context: context,
                              documents: provider.documents,
                              fName: fNameController.text.trim(),
                              sName: lNameController.text.trim(),
                              email: emailController.text.trim(),
                              qId: qIdController.text.trim(),
                              gender: selectedGender ?? '',
                              term: termsAccepted,
                              mobileNumber: widget.mobileNumber,
                            );
                            if (response is UserRegistrationSuccessModel) {
                              fNameController.clear();
                              lNameController.clear();
                              emailController.clear();
                              qIdController.clear();
                              provider.resetForm();
                              provider.documents.clear();
                              setState(() {
                                selectedGender = null;
                                termsAccepted = false;
                                showErrors = false; // Reset error display
                              });

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PersistantBottomNavBarScreen()),
                              );
                            }
                          }),
                    SizedBox(height: querySize.height * 0.08),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget errorText(String errorMessage) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: Text(
      errorMessage,
      style: const TextStyle(color: Colors.red, fontSize: 12),
    ),
  );
}

Widget countryInputField(
    BuildContext context, UserRegistrationProvider provider) {
  var sizeQuery = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Country",
        style: TextStyle(
          fontFamily: 'Jost',
          color: appColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: sizeQuery.height * 0.01),
      Container(
        height: sizeQuery.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => Container(
                height: 400,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Select Country',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.countries.length,
                        itemBuilder: (context, index) {
                          final country = provider.countries[index];
                          return ListTile(
                            title: Text(country.name),
                            onTap: () {
                              provider.setSelectedCountry(
                                  country.id, country.name);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(sizeQuery.height * 0.015),
                child: Image.asset(
                  "assets/images/flag_qatar.png",
                  width: sizeQuery.width * 0.08,
                  height: sizeQuery.height * 0.04,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: provider.countryController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
                    border: InputBorder.none,
                    hintText: 'Select Country',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: sizeQuery.height * 0.015,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
