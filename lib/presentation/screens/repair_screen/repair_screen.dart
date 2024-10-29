import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';

import 'package:lenore/presentation/screens/repair_screen/widget/custom_repair_check_box.dart';
import 'package:lenore/presentation/screens/repair_screen/widget/custom_repair_field.dart';
import 'package:provider/provider.dart';

class RepairScreen extends StatefulWidget {
  final Row widgetName;
  const RepairScreen({required this.widgetName, super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
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

  void validateAndSubmit() {
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
      Provider.of<CustomizationProvider>(context, listen: false)
          .sendCustomizationRequest(
        filterType: 'repair',
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
      );
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
                                items: ['Diamond', 'Gold', 'Platinum']
                                    .map((String value) {
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
  // TextEditingController dateController = TextEditingController();
  // @override
  // void dispose() {
  //   dateController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var querySize = MediaQuery.of(context).size;
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //         child: SingleChildScrollView(
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             customSizedBox(querySize),
  //             widget.widgetName,
  //             customSizedBox(querySize),
  //             // Text(
  //             //   "Customize",
  //             //   style: TextStyle(
  //             //       fontSize: querySize.width * 0.055,
  //             //       fontWeight: FontWeight.w600,
  //             //       fontFamily: 'ElMessiri',
  //             //       color: textColor),
  //             // ),
  //             // customSizedBox(querySize),
  //             Padding(
  //               padding: EdgeInsets.only(right: querySize.width * 0.049),
  //               child: Column(
  //                 children: [
  //                   customRepairField(
  //                       context,
  //                       "assets/images/profile/first_name_icon.png",
  //                       'Enter Your Name',
  //                       'Your Name'),
  //                   customSizedBox(querySize),
  //                   customRepairField(
  //                       context,
  //                       "assets/images/profile/qatar_flag_icon.png",
  //                       'Enter Your Number',
  //                       'Mobile Number'),
  //                   customSizedBox(querySize),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Estimated Date",
  //                         style: TextStyle(
  //                             fontFamily: 'Jost',
  //                             color: textColor,
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w400),
  //                       ),
  //                       SizedBox(
  //                         height: querySize.height * 0.01,
  //                       ),
  //                       Container(
  //                         height: querySize.height * 0.059,
  //                         decoration: BoxDecoration(
  //                           border: Border.all(
  //                               color: const Color(0xFF00ACB3), width: 1.5),
  //                           borderRadius:
  //                               BorderRadius.circular(querySize.width * 0.08),
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             Padding(
  //                               padding:
  //                                   EdgeInsets.all(querySize.height * 0.015),
  //                               child: GestureDetector(
  //                                 onTap: () async {
  //                                   DateTime? pickedDate = await showDatePicker(
  //                                     context: context,
  //                                     initialDate: DateTime.now()
  //                                         .add(const Duration(days: 1)),
  //                                     firstDate: DateTime.now()
  //                                         .add(const Duration(days: 1)),
  //                                     lastDate: DateTime(2100),
  //                                   );

  //                                   if (pickedDate != null) {
  //                                     dateController.text =
  //                                         "${pickedDate.toLocal()}"
  //                                             .split(' ')[0];
  //                                     // print(
  //                                     //     "Selected Date: ${pickedDate.toString()}");
  //                                   }
  //                                 },
  //                                 child: Image.asset(
  //                                   'assets/images/date_icon.png',
  //                                   width: querySize.width * 0.068,
  //                                   height: querySize.height * 0.028,
  //                                 ),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: TextField(
  //                                 controller: dateController,
  //                                 decoration: InputDecoration(
  //                                   hintStyle: const TextStyle(
  //                                       color: Color(0xFFD0D0D0)),
  //                                   border: InputBorder.none,
  //                                   hintText: 'yy/dd/mm',
  //                                   contentPadding: EdgeInsets.symmetric(
  //                                     vertical: querySize.height * 0.015,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   // calenderField(context, 'assets/images/date_icon.png',
  //                   //     'dd/mm/yy', 'Estimated Date'),
  //                   customSizedBox(querySize),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       customRepairCheckBox(querySize, "silver"),
  //                       customRepairCheckBox(querySize, "Gold"),
  //                       customRepairCheckBox(querySize, "Diamond")
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             customSizedBox(querySize),
  //             customSizedBox(querySize),
  //             Container(
  //               padding: EdgeInsets.all(querySize.width * 0.03),
  //               width: double.infinity,
  //               height: querySize.height * 0.19,
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFEFEEEE),
  //                 borderRadius: BorderRadius.circular(querySize.width * 0.03),
  //               ),
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     child: TextField(
  //                       maxLines: 4,
  //                       decoration: InputDecoration(
  //                         hintText: 'Note',
  //                         hintStyle: TextStyle(
  //                           fontFamily: 'Segoe',
  //                           fontSize: querySize.height * 0.02,
  //                           color: const Color(0xFF8C8C8C),
  //                         ),
  //                         border: InputBorder.none,
  //                       ),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomRight,
  //                     child: ElevatedButton.icon(
  //                       onPressed: () {
  //                         // Add image upload functionality here
  //                       },
  //                       icon: Image.asset(
  //                         'assets/images/upload_image_icon.png',
  //                         width: querySize.width * 0.05,
  //                         height: querySize.width * 0.05,
  //                       ),
  //                       label: Text(
  //                         'Upload Image',
  //                         style: TextStyle(
  //                             fontSize: querySize.width * 0.029,
  //                             fontWeight: FontWeight.w600,
  //                             fontFamily: 'Segoe',
  //                             color: Colors.white),
  //                       ),
  //                       style: ElevatedButton.styleFrom(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 12, vertical: 8),
  //                         backgroundColor: appColor,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius:
  //                               BorderRadius.circular(querySize.width * 0.05),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             customSizedBox(querySize),
  //             Align(
  //                 child: Container(
  //               width: querySize.width * 0.4,
  //               height: querySize.height * 0.053,
  //               decoration: BoxDecoration(
  //                 color: appColor,
  //                 borderRadius: BorderRadius.circular(querySize.width * 0.08),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   'Submit',
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.white,
  //                       fontFamily: 'Segoe',
  //                       fontSize: querySize.height * 0.017),
  //                 ),
  //               ),
  //             ))
  //           ],
  //         ),
  //       ),
  //     )),
  //   );
  // }
}

class CalenderField extends StatelessWidget {
  const CalenderField({
    super.key,
    required this.querySize,
  });

  final Size querySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Estimated Date",
          style: TextStyle(
              fontFamily: 'Jost',
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: querySize.height * 0.01,
        ),
        Container(
          height: querySize.height * 0.059,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
            borderRadius: BorderRadius.circular(querySize.width * 0.08),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(querySize.height * 0.015),
                child: GestureDetector(
                  onTap: () async {
                    // Show the date picker when the calendar icon is tapped
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now(), // Current date as the initial date
                      firstDate: DateTime(2000), // Minimum selectable date
                      lastDate: DateTime(2100), // Maximum selectable date
                    );

                    if (pickedDate != null) {
                      // Do something with the picked date
                      // print("Selected Date: ${pickedDate.toString()}");
                    }
                  },
                  child: Image.asset(
                    'assets/images/date_icon.png',
                    width: querySize.width * 0.068,
                    height: querySize.height * 0.028,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
                    border: InputBorder.none,
                    hintText: 'dd/mm/yy',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: querySize.height * 0.015,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
