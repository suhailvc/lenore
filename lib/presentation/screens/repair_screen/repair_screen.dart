import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/screens/repair_screen/widget/custom_repair_check_box.dart';
import 'package:lenore/presentation/screens/repair_screen/widget/custom_repair_field.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

class RepairScreen extends StatefulWidget {
  final Row widgetName;
  const RepairScreen({required this.widgetName, super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    customRepairField(
                        context,
                        "assets/images/profile/first_name_icon.png",
                        'Enter Your Name',
                        'Your Name'),
                    customSizedBox(querySize),
                    customRepairField(
                        context,
                        "assets/images/profile/qatar_flag_icon.png",
                        'Enter Your Number',
                        'Mobile Number'),
                    customSizedBox(querySize),
                    Column(
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
                            border: Border.all(
                                color: const Color(0xFF00ACB3), width: 1.5),
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.08),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.all(querySize.height * 0.015),
                                child: GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now()
                                          .add(const Duration(days: 1)),
                                      firstDate: DateTime.now()
                                          .add(const Duration(days: 1)),
                                      lastDate: DateTime(2100),
                                    );

                                    if (pickedDate != null) {
                                      dateController.text =
                                          "${pickedDate.toLocal()}"
                                              .split(' ')[0];
                                      // print(
                                      //     "Selected Date: ${pickedDate.toString()}");
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
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFFD0D0D0)),
                                    border: InputBorder.none,
                                    hintText: 'yy/dd/mm',
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
                    ),
                    // calenderField(context, 'assets/images/date_icon.png',
                    //     'dd/mm/yy', 'Estimated Date'),
                    customSizedBox(querySize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customRepairCheckBox(querySize, "silver"),
                        customRepairCheckBox(querySize, "Gold"),
                        customRepairCheckBox(querySize, "Diamond")
                      ],
                    ),
                  ],
                ),
              ),
              customSizedBox(querySize),
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
