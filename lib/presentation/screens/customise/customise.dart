import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_check_box.dart';
import 'package:lenore/presentation/screens/customise/widget/custom_customise_filed.dart';
import 'package:lenore/presentation/screens/customise/widget/wight_and_purity_button.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

class CustomisationScreen extends StatefulWidget {
  final Row widgetName;
  const CustomisationScreen({required this.widgetName, super.key});

  @override
  State<CustomisationScreen> createState() => _CustomisationScreenState();
}

class _CustomisationScreenState extends State<CustomisationScreen> {
  @override
  Widget build(BuildContext context) {
    String? selectedProductType;
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
              widget.widgetName, customSizedBox(querySize),
              // Text(
              //   "Customize",
              //   style: TextStyle(
              //       fontSize: querySize.width * 0.055,
              //       fontWeight: FontWeight.w600,
              //       fontFamily: 'ElMessiri',
              //       color: textColor),
              // ),
              // customSizedBox(querySize),
              Padding(
                padding: EdgeInsets.only(right: querySize.width * 0.049),
                child: Column(
                  children: [
                    customCustomiseField(
                        context,
                        "assets/images/profile/first_name_icon.png",
                        'Enter Your Name',
                        'Your Name'),
                    customSizedBox(querySize),
                    customCustomiseField(
                        context,
                        "assets/images/profile/qatar_flag_icon.png",
                        'Enter Your Number',
                        'Mobile Number'),
                    customSizedBox(querySize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCustomisationCheckBox(querySize, "silver"),
                        customCustomisationCheckBox(querySize, "Gold"),
                        customCustomisationCheckBox(querySize, "Diamond")
                      ],
                    ),
                    customSizedBox(querySize),
                    Row(
                      children: [
                        weightAndPurityButton(querySize, "Weight"),
                        SizedBox(
                          width: querySize.width * 0.05,
                        ),
                        weightAndPurityButton(querySize, "Purity"),
                      ],
                    )
                  ],
                ),
              ),
              customSizedBox(querySize),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.03),
                width: querySize.width * 0.36,
                height: querySize.height * 0.05,
                decoration: BoxDecoration(
                    color: const Color(0xffEFEEEE),
                    borderRadius:
                        BorderRadius.circular(querySize.width * 0.03)),
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
                      items:
                          ['Diamond', 'Gold', 'Platinum'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProductType =
                              newValue; // Update the selected value
                        });
                      },
                    ),
                  ),
                ),
              ),
              customSizedBox(querySize),
              Container(
                padding: EdgeInsets.all(querySize.width * 0.03),
                width: double.infinity,
                height: querySize.height * 0.19,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEEEE),
                  borderRadius: BorderRadius.circular(querySize.width * 0.03),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 4,
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
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add image upload functionality here
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
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          backgroundColor: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.05),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              customSizedBox(querySize),
              Align(
                  child: Container(
                width: querySize.width * 0.4,
                height: querySize.height * 0.053,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.08),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }
}
