import 'package:flutter/material.dart';
import 'package:lenore/application/provider/otp_provider/otp_provider.dart';
import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:lenore/presentation/screens/home/home_screen.dart';

import 'package:lenore/presentation/screens/login_screen/personal_details_screen/widgets/user_input_field.dart';
import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final String mobileNumber;
  const PersonalDetailsScreen({required this.mobileNumber, super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    List<String> genderOptions = ['Male', 'Female'];
    String? selectedGender;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: querySize.height * 0.05,
                ),
                const Text(
                  'Welcome to Lenore',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Lora'),
                ),
                SizedBox(
                  height: querySize.height * 0.01,
                ),
                const Text(
                  'Enter Your Personal Details',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lora'),
                ),
                SizedBox(
                  height: querySize.height * 0.02,
                ),
                userInputField(context, "assets/images/profile.png",
                    "Enter Your First Name", "First Name"),
                SizedBox(
                  height: querySize.height * 0.03,
                ),
                userInputField(context, "assets/images/profile.png",
                    "Enter Your Last Name", "Last Name"),
                SizedBox(
                  height: querySize.height * 0.03,
                ),
                userInputField(context, "assets/images/email.png",
                    "Enter Your Email", "Email"),
                SizedBox(
                  height: querySize.height * 0.03,
                ),
                userInputField(context, "assets/images/flag_qatar.png",
                    "QID No", "QID/ Passport"),
                SizedBox(
                  height: querySize.height * 0.03,
                ),
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
                    SizedBox(
                      height: querySize.height * 0.01,
                    ),
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
                                      style:
                                          TextStyle(color: Color(0xFFD0D0D0)),
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
                                    value: gender,
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
                  ],
                ),
                SizedBox(
                  height: querySize.height * 0.02,
                ),
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      activeColor: textColor,
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(
                          width: querySize.width * 0.003,
                          color: textColor,
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                    Text(
                      "I have read and agee to terms and conditions",
                      style: TextStyle(
                          fontSize: querySize.width * 0.031,
                          color: appColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe'),
                    )
                  ],
                ),
                customSizedBox(querySize),
                Text(
                  "Note : Our team will contact you to confirm the ID number /\nPassport number",
                  style: TextStyle(
                      fontSize: querySize.width * 0.031,
                      color: const Color(0xFF7F7F7F),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Segoe'),
                ),
                SizedBox(
                  height: querySize.height * 0.05,
                ),
                Consumer<UserRegistrationProvider>(
                    builder: (context, otpProvider, child) {
                  return otpProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : loginCustomButton(context, querySize, "CONTINUE", () {
                          otpProvider.userRegistration(
                              fName: 'muhammad',
                              sName: 'suhail',
                              email: 'muhammad@gmail.com',
                              qId: '12345678',
                              gender: 'male',
                              term: true,
                              mobileNumber: widget.mobileNumber);
                        });
                }),
                SizedBox(
                  height: querySize.height * 0.08,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
