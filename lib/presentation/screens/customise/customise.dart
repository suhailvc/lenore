import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';
import 'package:provider/provider.dart';

class CustomisationScreen extends StatefulWidget {
  final Row widgetName;
  const CustomisationScreen({required this.widgetName, super.key});

  @override
  State<CustomisationScreen> createState() => _CustomisationScreenState();
}

class _CustomisationScreenState extends State<CustomisationScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final weightController = TextEditingController();
  final purityController = TextEditingController();
  final messageController = TextEditingController();

  String? selectedProductType;
  bool isSilverSelected = true;
  bool isGoldSelected = false;
  bool isDiamondSelected = false;

  // Error message variables
  String? nameError;
  String? phoneError;
  String? weightError;
  String? purityError;
  String? productTypeError;
  String? messageError;

  void validateAndSubmit() async {
    print('submitted');
    setState(() {
      // Reset errors
      nameError = null;
      phoneError = null;
      weightError = null;
      purityError = null;
      productTypeError = null;
      messageError = null;

      // Validate fields
      if (nameController.text.isEmpty) nameError = "Name is required";
      if (numberController.text.isEmpty || numberController.text.length != 8)
        phoneError = "Phone number is required";
      if (numberController.text.length != 8)
        phoneError = "8 Digit Phone number is required";
      if (weightController.text.isEmpty) weightError = "Weight is required";
      if (purityController.text.isEmpty) purityError = "Purity is required";
      if (selectedProductType == null)
        productTypeError = "Product type is required";
      if (messageController.text.isEmpty) messageError = "Note is required";
    });

    // Check if all required fields are valid
    if (nameError == null &&
        phoneError == null &&
        weightError == null &&
        purityError == null &&
        productTypeError == null &&
        messageError == null) {
      // Submit the form if no errors
      await Provider.of<CustomizationProvider>(context, listen: false)
          .sendCustomizationRequest(
        filterType: 'customisation',
        name: nameController.text,
        phone: numberController.text,
        type: isGoldSelected
            ? "Gold"
            : isSilverSelected
                ? "Silver"
                : isDiamondSelected
                    ? "Diamond"
                    : "",
        weight: weightController.text,
        purity: purityController.text,
        productType: selectedProductType ?? "",
        message: messageController.text,
      ); // Access the provider's response message to check for success
      final provider =
          Provider.of<CustomizationProvider>(context, listen: false);
      if (provider.responseMessage == "customisation request submitted") {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Customization form is submitted"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Clear fields and reset UI state after successful submission
        setState(() {
          nameController.clear();
          numberController.clear();
          weightController.clear();
          purityController.clear();
          messageController.clear();
          isSilverSelected = false;
          isGoldSelected = false;
          isDiamondSelected = false;
          selectedProductType = null;
          provider.clearImages(); // Clears selected images
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customizationProvider = Provider.of<CustomizationProvider>(context);
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSizedBox(querySize),
                widget.widgetName,
                customSizedBox(querySize),
                Padding(
                  padding: EdgeInsets.only(right: querySize.width * 0.049),
                  child: Column(
                    children: [
                      // Name Field and Error Message
                      customCustomiseField(
                        assetName: "assets/images/profile/first_name_icon.png",
                        context: context,
                        controller: nameController,
                        errorText: nameError,
                        fieldText: 'Enter Your Name',
                        name: 'Your Name',
                      ),
                      if (nameError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(nameError!,
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      customSizedBox(querySize),

                      // Mobile Number Field and Error Message
                      customCustomiseField(
                        assetName: "assets/images/profile/qatar_flag_icon.png",
                        context: context,
                        controller: numberController,
                        errorText: phoneError,
                        fieldText: 'Enter Your Number',
                        name: 'Mobile Number',
                      ),
                      if (phoneError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(phoneError!,
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      customSizedBox(querySize),

                      // Type Checkboxes - Only one can be selected at a time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customCustomisationCheckBox(
                            querySize,
                            "Silver",
                            isSilverSelected,
                            (value) => setState(() {
                              isSilverSelected = value ?? false;
                              isGoldSelected = false;
                              isDiamondSelected = false;
                            }),
                          ),
                          customCustomisationCheckBox(
                            querySize,
                            "Gold",
                            isGoldSelected,
                            (value) => setState(() {
                              isGoldSelected = value ?? false;
                              isSilverSelected = false;
                              isDiamondSelected = false;
                            }),
                          ),
                          customCustomisationCheckBox(
                            querySize,
                            "Diamond",
                            isDiamondSelected,
                            (value) => setState(() {
                              isDiamondSelected = value ?? false;
                              isSilverSelected = false;
                              isGoldSelected = false;
                            }),
                          ),
                        ],
                      ),
                      customSizedBox(querySize),

                      // Weight and Purity Fields with Error Messages
                      Row(
                        children: [
                          weightAndPurityButton(
                            errorText: weightError,
                            context: context,
                            controller: weightController,
                            hintText: 'Weight',
                          ),
                          SizedBox(width: querySize.width * 0.05),
                          weightAndPurityButton(
                            errorText: purityError,
                            context: context,
                            controller: purityController,
                            hintText: "Purity",
                          ),
                        ],
                      ),
                      customSizedBox(querySize),

                      // Product Type Dropdown with Error Message
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: querySize.width * 0.03),
                          width: querySize.width * 0.36,
                          height: querySize.height * 0.05,
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEEEE),
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.03),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedProductType,
                                hint: Text(
                                  'Product type',
                                  style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: querySize.width * 0.038,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF8C8C8C),
                                  ),
                                ),
                                isExpanded: true,
                                icon: Image.asset(
                                  "assets/images/drop_down_icon.png",
                                  width: querySize.width * 0.038,
                                  height: querySize.height * 0.038,
                                ),
                                items: [
                                  'Ring',
                                  'Nicklase',
                                  'Earring',
                                  'Bracelet',
                                  'Chain',
                                  'Bangle',
                                  'Pendant',
                                  'Anklet'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedProductType = newValue;
                                    productTypeError =
                                        null; // Reset error on change
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (productTypeError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(productTypeError!,
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      customSizedBox(querySize),

                      // Message Field with Error Message and Upload Image Section
                      Container(
                        padding: EdgeInsets.all(querySize.width * 0.03),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEEEE),
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.03),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: messageController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Note',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.02,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF8C8C8C),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            if (messageError != null)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(messageError!,
                                    style: TextStyle(color: Colors.red)),
                              ),
                          ],
                        ),
                      ),
                      customSizedBox(querySize),
                      Container(
                        padding: EdgeInsets.all(querySize.width * 0.03),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEEEE),
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.03),
                        ),
                        child: Column(
                          children: [
                            // Display up to 3 selected images
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: customizationProvider.selectedImages
                                  .take(3) // Only take the first 3 images
                                  .map((image) {
                                int index = customizationProvider.selectedImages
                                    .indexOf(image);
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        image,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (index == 2 &&
                                        customizationProvider
                                                .selectedImages.length >
                                            3)
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.black.withOpacity(0.6),
                                          child: Center(
                                            child: Text(
                                              '+${customizationProvider.selectedImages.length - 3}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await customizationProvider
                                      .pickImage(ImageSource.gallery);
                                },
                                icon: Image.asset(
                                  'assets/images/upload_image_icon.png',
                                  width: querySize.width * 0.05,
                                  height: querySize.width * 0.05,
                                ),
                                label: Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontSize: querySize.width * 0.029,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Segoe',
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  backgroundColor: appColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.05),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      customSizedBox(querySize),

                      // Submit Button
                      Align(
                        child: ElevatedButton(
                          onPressed: validateAndSubmit,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.017,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(querySize.width * 0.4,
                                querySize.height * 0.053),
                            backgroundColor: appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(querySize.width * 0.08),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomisationScreen extends StatefulWidget {
//   final Row widgetName;
//   const CustomisationScreen({required this.widgetName, super.key});

//   @override
//   State<CustomisationScreen> createState() => _CustomisationScreenState();
// }

// class _CustomisationScreenState extends State<CustomisationScreen> {
//   final nameController = TextEditingController();
//   final numberController = TextEditingController();
//   final weightController = TextEditingController();
//   final purityController = TextEditingController();
//   final messageController = TextEditingController();

//   String? selectedProductType;
//   bool isSilverSelected = false;
//   bool isGoldSelected = false;
//   bool isDiamondSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     final customizationProvider = Provider.of<CustomizationProvider>(context);
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customSizedBox(querySize),
//                 widget.widgetName,
//                 customSizedBox(querySize),
//                 Padding(
//                   padding: EdgeInsets.only(right: querySize.width * 0.049),
//                   child: Column(
//                     children: [
//                       customCustomiseField(
//                         assetName: "assets/images/profile/first_name_icon.png",
//                         context: context,
//                         controller: nameController,
//                         errorText:
//                             customizationProvider.errors['name']?.join(", "),
//                         fieldText: 'Enter Your Name',
//                         name: 'Your Name',
//                       ),
//                       customSizedBox(querySize),
//                       customCustomiseField(
//                         assetName: "assets/images/profile/qatar_flag_icon.png",
//                         context: context,
//                         controller: numberController,
//                         errorText:
//                             customizationProvider.errors['phone']?.join(", "),
//                         fieldText: 'Enter Your Number',
//                         name: 'Mobile Number',
//                       ),
//                       customSizedBox(querySize),

//                       // Type Checkboxes - Only one can be selected at a time
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Silver",
//                             isSilverSelected,
//                             (value) => setState(() {
//                               isSilverSelected = value ?? false;
//                               isGoldSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Gold",
//                             isGoldSelected,
//                             (value) => setState(() {
//                               isGoldSelected = value ?? false;
//                               isSilverSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Diamond",
//                             isDiamondSelected,
//                             (value) => setState(() {
//                               isDiamondSelected = value ?? false;
//                               isSilverSelected = false;
//                               isGoldSelected = false;
//                             }),
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Weight and Purity
//                       Row(
//                         children: [
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['weight']
//                                 ?.join(", "),
//                             context: context,
//                             controller: weightController,
//                             hintText: 'Weight',
//                           ),
//                           SizedBox(width: querySize.width * 0.05),
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['purity']
//                                 ?.join(", "),
//                             context: context,
//                             controller: purityController,
//                             hintText: "Purity",
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Product Type Dropdown
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.03),
//                         width: querySize.width * 0.36,
//                         height: querySize.height * 0.05,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Center(
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               value: selectedProductType,
//                               hint: Text(
//                                 'Product type',
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.width * 0.038,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF8C8C8C),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               icon: Image.asset(
//                                 "assets/images/drop_down_icon.png",
//                                 width: querySize.width * 0.038,
//                                 height: querySize.height * 0.038,
//                               ),
//                               items: ['Diamond', 'Gold', 'Platinum']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   selectedProductType = newValue;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Message Field with Uploaded Images
//                       Container(
//                         padding: EdgeInsets.all(querySize.width * 0.03),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextField(
//                               controller: messageController,
//                               maxLines: 3,
//                               decoration: InputDecoration(
//                                 hintText: 'Note',
//                                 hintStyle: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.height * 0.02,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF8C8C8C),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                             SizedBox(height: 8),

//                             // Display up to 3 selected images
//                             Wrap(
//                               spacing: 8.0,
//                               runSpacing: 8.0,
//                               children: customizationProvider.selectedImages
//                                   .take(3) // Only take the first 3 images
//                                   .map((image) {
//                                 int index = customizationProvider.selectedImages
//                                     .indexOf(image);
//                                 return Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.file(
//                                         image,
//                                         width: 80,
//                                         height: 80,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     if (index == 2 &&
//                                         customizationProvider
//                                                 .selectedImages.length >
//                                             3)
//                                       Positioned.fill(
//                                         child: Container(
//                                           color: Colors.black.withOpacity(0.6),
//                                           child: Center(
//                                             child: Text(
//                                               '+${customizationProvider.selectedImages.length - 3}',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 );
//                               }).toList(),
//                             ),

//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton.icon(
//                                 onPressed: () async {
//                                   await customizationProvider
//                                       .pickImage(ImageSource.gallery);
//                                 },
//                                 icon: Image.asset(
//                                   'assets/images/upload_image_icon.png',
//                                   width: querySize.width * 0.05,
//                                   height: querySize.width * 0.05,
//                                 ),
//                                 label: Text(
//                                   'Upload Image',
//                                   style: TextStyle(
//                                     fontSize: querySize.width * 0.029,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Segoe',
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   backgroundColor: appColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.05),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Submit Button
//                       Align(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await customizationProvider
//                                 .sendCustomizationRequest(
//                               name: nameController.text,
//                               phone: numberController.text,
//                               type: isGoldSelected
//                                   ? "Gold"
//                                   : isSilverSelected
//                                       ? "Silver"
//                                       : isDiamondSelected
//                                           ? "Diamond"
//                                           : "",
//                               weight: weightController.text,
//                               purity: purityController.text,
//                               productType: selectedProductType ?? "",
//                               message: messageController.text,
//                             );

//                             // Clear fields if submission was successful
//                             if (customizationProvider.responseMessage ==
//                                 "Success") {
//                               setState(() {
//                                 nameController.clear();
//                                 numberController.clear();
//                                 weightController.clear();
//                                 purityController.clear();
//                                 messageController.clear();
//                                 isSilverSelected = false;
//                                 isGoldSelected = false;
//                                 isDiamondSelected = false;
//                                 selectedProductType = null;
//                                 customizationProvider.clearImages();
//                               });
//                             }
//                           },
//                           child: Text(
//                             'Submit',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.height * 0.017,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(querySize.width * 0.4,
//                                 querySize.height * 0.053),
//                             backgroundColor: appColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.08),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
// import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';

// class CustomisationScreen extends StatefulWidget {
//   final Row widgetName;
//   const CustomisationScreen({required this.widgetName, super.key});

//   @override
//   State<CustomisationScreen> createState() => _CustomisationScreenState();
// }

// class _CustomisationScreenState extends State<CustomisationScreen> {
//   final nameController = TextEditingController();
//   final numberController = TextEditingController();
//   final weightController = TextEditingController();
//   final purityController = TextEditingController();
//   final messageController = TextEditingController();

//   String? selectedProductType;
//   bool isSilverSelected = false;
//   bool isGoldSelected = false;
//   bool isDiamondSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     final customizationProvider = Provider.of<CustomizationProvider>(context);
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customSizedBox(querySize),
//                 widget.widgetName,
//                 customSizedBox(querySize),
//                 Padding(
//                   padding: EdgeInsets.only(right: querySize.width * 0.049),
//                   child: Column(
//                     children: [
//                       customCustomiseField(
//                         assetName: "assets/images/profile/first_name_icon.png",
//                         context: context,
//                         controller: nameController,
//                         errorText:
//                             customizationProvider.errors['name']?.join(", "),
//                         fieldText: 'Enter Your Name',
//                         name: 'Your Name',
//                       ),
//                       customSizedBox(querySize),
//                       customCustomiseField(
//                         assetName: "assets/images/profile/qatar_flag_icon.png",
//                         context: context,
//                         controller: numberController,
//                         errorText:
//                             customizationProvider.errors['phone']?.join(", "),
//                         fieldText: 'Enter Your Number',
//                         name: 'Mobile Number',
//                       ),
//                       customSizedBox(querySize),

//                       // Type Checkboxes - Only one can be selected at a time
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Silver",
//                             isSilverSelected,
//                             (value) => setState(() {
//                               isSilverSelected = value ?? false;
//                               isGoldSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Gold",
//                             isGoldSelected,
//                             (value) => setState(() {
//                               isGoldSelected = value ?? false;
//                               isSilverSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Diamond",
//                             isDiamondSelected,
//                             (value) => setState(() {
//                               isDiamondSelected = value ?? false;
//                               isSilverSelected = false;
//                               isGoldSelected = false;
//                             }),
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Weight and Purity
//                       Row(
//                         children: [
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['weight']
//                                 ?.join(", "),
//                             context: context,
//                             controller: weightController,
//                             hintText: 'Weight',
//                           ),
//                           SizedBox(width: querySize.width * 0.05),
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['purity']
//                                 ?.join(", "),
//                             context: context,
//                             controller: purityController,
//                             hintText: "Purity",
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Product Type Dropdown
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.03),
//                         width: querySize.width * 0.36,
//                         height: querySize.height * 0.05,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Center(
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               value: selectedProductType,
//                               hint: Text(
//                                 'Product type',
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.width * 0.038,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF8C8C8C),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               icon: Image.asset(
//                                 "assets/images/drop_down_icon.png",
//                                 width: querySize.width * 0.038,
//                                 height: querySize.height * 0.038,
//                               ),
//                               items: ['Diamond', 'Gold', 'Platinum']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   selectedProductType = newValue;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Message Field with Uploaded Images
//                       Container(
//                         padding: EdgeInsets.all(querySize.width * 0.03),
//                         width: double.infinity,
//                         height: querySize.height * 0.25,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 controller: messageController,
//                                 maxLines: 3,
//                                 decoration: InputDecoration(
//                                   hintText: 'Note',
//                                   hintStyle: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: querySize.height * 0.02,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF8C8C8C),
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),

//                             // Display selected images in a Wrap widget
//                             Wrap(
//                               spacing: 8.0,
//                               runSpacing: 8.0,
//                               children: customizationProvider.selectedImages
//                                   .map((image) {
//                                 return Stack(
//                                   children: [
//                                     Image.file(
//                                       image,
//                                       width: 80,
//                                       height: 80,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Positioned(
//                                       top: 0,
//                                       right: 0,
//                                       child: IconButton(
//                                         icon: Icon(Icons.cancel,
//                                             color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             customizationProvider.selectedImages
//                                                 .remove(image);
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }).toList(),
//                             ),

//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton.icon(
//                                 onPressed: () async {
//                                   await customizationProvider
//                                       .pickImage(ImageSource.gallery);
//                                 },
//                                 icon: Image.asset(
//                                   'assets/images/upload_image_icon.png',
//                                   width: querySize.width * 0.05,
//                                   height: querySize.width * 0.05,
//                                 ),
//                                 label: Text(
//                                   'Upload Image',
//                                   style: TextStyle(
//                                     fontSize: querySize.width * 0.029,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Segoe',
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   backgroundColor: appColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.05),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Submit Button
//                       Align(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await customizationProvider
//                                 .sendCustomizationRequest(
//                               name: nameController.text,
//                               phone: numberController.text,
//                               type: isGoldSelected
//                                   ? "Gold"
//                                   : isSilverSelected
//                                       ? "Silver"
//                                       : isDiamondSelected
//                                           ? "Diamond"
//                                           : "",
//                               weight: weightController.text,
//                               purity: purityController.text,
//                               productType: selectedProductType ?? "",
//                               message: messageController.text,
//                             );

//                             // Clear fields if submission was successful
//                             if (customizationProvider.responseMessage ==
//                                 "Success") {
//                               setState(() {
//                                 nameController.clear();
//                                 numberController.clear();
//                                 weightController.clear();
//                                 purityController.clear();
//                                 messageController.clear();
//                                 isSilverSelected = false;
//                                 isGoldSelected = false;
//                                 isDiamondSelected = false;
//                                 selectedProductType = null;
//                                 customizationProvider.clearImages();
//                               });
//                             }
//                           },
//                           child: Text(
//                             'Submit',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.height * 0.017,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(querySize.width * 0.4,
//                                 querySize.height * 0.053),
//                             backgroundColor: appColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.08),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
// import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';
// import 'package:provider/provider.dart';

// class CustomisationScreen extends StatefulWidget {
//   final Row widgetName;
//   const CustomisationScreen({required this.widgetName, super.key});

//   @override
//   State<CustomisationScreen> createState() => _CustomisationScreenState();
// }

// class _CustomisationScreenState extends State<CustomisationScreen> {
//   final nameController = TextEditingController();
//   final numberController = TextEditingController();
//   final weightController = TextEditingController();
//   final purityController = TextEditingController();
//   final messageController = TextEditingController();

//   String? selectedProductType;
//   bool isSilverSelected = false;
//   bool isGoldSelected = false;
//   bool isDiamondSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     final customizationProvider = Provider.of<CustomizationProvider>(context);
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customSizedBox(querySize),
//                 widget.widgetName,
//                 customSizedBox(querySize),
//                 Padding(
//                   padding: EdgeInsets.only(right: querySize.width * 0.049),
//                   child: Column(
//                     children: [
//                       customCustomiseField(
//                         assetName: "assets/images/profile/first_name_icon.png",
//                         context: context,
//                         controller: nameController,
//                         errorText:
//                             customizationProvider.errors['name']?.join(", "),
//                         fieldText: 'Enter Your Name',
//                         name: 'Your Name',
//                       ),
//                       customSizedBox(querySize),
//                       customCustomiseField(
//                         assetName: "assets/images/profile/qatar_flag_icon.png",
//                         context: context,
//                         controller: numberController,
//                         errorText:
//                             customizationProvider.errors['phone']?.join(", "),
//                         fieldText: 'Enter Your Number',
//                         name: 'Mobile Number',
//                       ),
//                       customSizedBox(querySize),

//                       // Type Checkboxes - Only one can be selected at a time
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Silver",
//                             isSilverSelected,
//                             (value) => setState(() {
//                               isSilverSelected = value ?? false;
//                               isGoldSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Gold",
//                             isGoldSelected,
//                             (value) => setState(() {
//                               isGoldSelected = value ?? false;
//                               isSilverSelected = false;
//                               isDiamondSelected = false;
//                             }),
//                           ),
//                           customCustomisationCheckBox(
//                             querySize,
//                             "Diamond",
//                             isDiamondSelected,
//                             (value) => setState(() {
//                               isDiamondSelected = value ?? false;
//                               isSilverSelected = false;
//                               isGoldSelected = false;
//                             }),
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Weight and Purity
//                       Row(
//                         children: [
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['weight']
//                                 ?.join(", "),
//                             context: context,
//                             controller: weightController,
//                             hintText: 'Weight',
//                           ),
//                           SizedBox(width: querySize.width * 0.05),
//                           weightAndPurityButton(
//                             errorText: customizationProvider.errors['purity']
//                                 ?.join(", "),
//                             context: context,
//                             controller: purityController,
//                             hintText: "Purity",
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),

//                       // Product Type Dropdown
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.03),
//                         width: querySize.width * 0.36,
//                         height: querySize.height * 0.05,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Center(
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               value: selectedProductType,
//                               hint: Text(
//                                 'Product type',
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.width * 0.038,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF8C8C8C),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               icon: Image.asset(
//                                 "assets/images/drop_down_icon.png",
//                                 width: querySize.width * 0.038,
//                                 height: querySize.height * 0.038,
//                               ),
//                               items: ['Diamond', 'Gold', 'Platinum']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   selectedProductType = newValue;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Message Field with Upload Image Button
//                       Container(
//                         padding: EdgeInsets.all(querySize.width * 0.03),
//                         width: double.infinity,
//                         height: querySize.height * 0.19,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEFEEEE),
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 controller: messageController,
//                                 maxLines: 3,
//                                 decoration: InputDecoration(
//                                   hintText: 'Note',
//                                   hintStyle: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: querySize.height * 0.02,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF8C8C8C),
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton.icon(
//                                 onPressed: () async {
//                                   await customizationProvider
//                                       .pickImage(ImageSource.gallery);
//                                 },
//                                 icon: Image.asset(
//                                   'assets/images/upload_image_icon.png',
//                                   width: querySize.width * 0.05,
//                                   height: querySize.width * 0.05,
//                                 ),
//                                 label: Text(
//                                   'Upload Image',
//                                   style: TextStyle(
//                                     fontSize: querySize.width * 0.029,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Segoe',
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   backgroundColor: appColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.05),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       customSizedBox(querySize),

//                       // Submit Button
//                       Align(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await customizationProvider
//                                 .sendCustomizationRequest(
//                               name: nameController.text,
//                               phone: numberController.text,
//                               type: isGoldSelected
//                                   ? "Gold"
//                                   : isSilverSelected
//                                       ? "Silver"
//                                       : isDiamondSelected
//                                           ? "Diamond"
//                                           : "",
//                               weight: weightController.text,
//                               purity: purityController.text,
//                               productType: selectedProductType ?? "",
//                               message: messageController.text,
//                             );

//                             // Clear fields if submission was successful
//                             if (customizationProvider.responseMessage ==
//                                 "Success") {
//                               setState(() {
//                                 nameController.clear();
//                                 numberController.clear();
//                                 weightController.clear();
//                                 purityController.clear();
//                                 messageController.clear();
//                                 isSilverSelected = false;
//                                 isGoldSelected = false;
//                                 isDiamondSelected = false;
//                                 selectedProductType = null;
//                               });
//                             }
//                           },
//                           child: Text(
//                             'Submit',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.height * 0.017,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(querySize.width * 0.4,
//                                 querySize.height * 0.053),
//                             backgroundColor: appColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.08),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
// import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
// import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';
// import 'package:provider/provider.dart';

// class CustomisationScreen extends StatefulWidget {
//   final Row widgetName;
//   const CustomisationScreen({required this.widgetName, super.key});

//   @override
//   State<CustomisationScreen> createState() => _CustomisationScreenState();
// }

// class _CustomisationScreenState extends State<CustomisationScreen> {
//   final nameController = TextEditingController();
//   final numberController = TextEditingController();
//   final typeController = TextEditingController();
//   final weightController = TextEditingController();
//   final purityController = TextEditingController();
//   final productTypeController = TextEditingController();
//   final messageController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final customizationProvider = Provider.of<CustomizationProvider>(context);
//     String? selectedProductType;
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               customSizedBox(querySize),
//               widget.widgetName,
//               customSizedBox(querySize),
//               Padding(
//                 padding: EdgeInsets.only(right: querySize.width * 0.049),
//                 child: Column(
//                   children: [
//                     customCustomiseField(
//                       assetName: "assets/images/profile/first_name_icon.png",
//                       context: context,
//                       controller: nameController,
//                       errorText:
//                           customizationProvider.errors['weight']?.join(", "),
//                       fieldText: 'Enter Your Name',
//                       name: 'Your Name',
//                     ),
//                     customSizedBox(querySize),
//                     customCustomiseField(
//                         assetName: "assets/images/profile/qatar_flag_icon.png",
//                         context: context,
//                         controller: numberController,
//                         errorText:
//                             customizationProvider.errors['phone']?.join(", "),
//                         fieldText: 'Enter Your Number',
//                         name: 'Mobile Number'),
//                     customSizedBox(querySize),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         customCustomisationCheckBox(querySize, "silver"),
//                         customCustomisationCheckBox(querySize, "Gold"),
//                         customCustomisationCheckBox(querySize, "Diamond")
//                       ],
//                     ),
//                     customSizedBox(querySize),
//                     Row(
//                       children: [
//                         weightAndPurityButton(
//                           errorText: customizationProvider.errors['weight']
//                               ?.join(", "),
//                           context: context,
//                           controller: weightController,
//                           hintText: 'Weight',
//                         ),
//                         SizedBox(
//                           width: querySize.width * 0.05,
//                         ),
//                         weightAndPurityButton(
//                           errorText: customizationProvider.errors['purity']
//                               ?.join(", "),
//                           context: context,
//                           controller: purityController,
//                           hintText: "Purity",
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               customSizedBox(querySize),
//               Container(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: querySize.width * 0.03),
//                 width: querySize.width * 0.36,
//                 height: querySize.height * 0.05,
//                 decoration: BoxDecoration(
//                     color: const Color(0xffEFEEEE),
//                     borderRadius:
//                         BorderRadius.circular(querySize.width * 0.03)),
//                 child: Center(
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: selectedProductType,
//                       hint: Text(
//                         'Product type',
//                         style: TextStyle(
//                           fontFamily: 'Segoe',
//                           fontSize: querySize.width * 0.038,
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xFF8C8C8C),
//                         ),
//                       ),
//                       isExpanded: true,
//                       icon: Image.asset(
//                         "assets/images/drop_down_icon.png",
//                         width: querySize.width * 0.038,
//                         height: querySize.height * 0.038,
//                       ),
//                       items:
//                           ['Diamond', 'Gold', 'Platinum'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedProductType = newValue;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               customSizedBox(querySize),
//               Container(
//                 padding: EdgeInsets.all(querySize.width * 0.03),
//                 width: double.infinity,
//                 height: querySize.height * 0.19,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEFEEEE),
//                   borderRadius: BorderRadius.circular(querySize.width * 0.03),
//                 ),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: messageController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           hintText: 'Note',
//                           hintStyle: TextStyle(
//                             fontFamily: 'Segoe',
//                             fontSize: querySize.height * 0.02,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xFF8C8C8C),
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: ElevatedButton.icon(
//                         onPressed: () async {
//                           await customizationProvider
//                               .pickImage(ImageSource.gallery);
//                         },
//                         icon: Image.asset(
//                           'assets/images/upload_image_icon.png',
//                           width: querySize.width * 0.05,
//                           height: querySize.width * 0.05,
//                         ),
//                         label: Text(
//                           'Upload Image',
//                           style: TextStyle(
//                               fontSize: querySize.width * 0.029,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'Segoe',
//                               color: Colors.white),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 8),
//                           backgroundColor: appColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(querySize.width * 0.05),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               customSizedBox(querySize),
//               Align(
//                   child: Container(
//                 width: querySize.width * 0.4,
//                 height: querySize.height * 0.053,
//                 decoration: BoxDecoration(
//                   color: appColor,
//                   borderRadius: BorderRadius.circular(querySize.width * 0.08),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                         fontFamily: 'Segoe',
//                         fontSize: querySize.height * 0.017),
//                   ),
//                 ),
//               ))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
