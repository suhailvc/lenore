import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/edit_profile_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    List<String> genderOptions = ['Male', 'Female'];
    String? selectedGender;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: querySize.height * 0.07),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.05),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.02),
                  child: Column(
                    children: [
                      customHeightThree(querySize),
                      CircleAvatar(
                        radius: querySize.width * 0.13,
                        foregroundImage: const AssetImage(
                          'assets/images/profile/profile_picture_image.png',
                        ),
                      ),
                      customSizedBox(querySize),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: const Color(0xFF00ACB3),
                          fontSize: querySize.height * 0.022,
                          fontFamily: 'Segoe',
                        ),
                      ),
                      customSizedBox(querySize),
                      SizedBox(
                        height: querySize.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: querySize.width * 0.04),
                        child: Column(
                          children: [
                            editProfileField(
                                context,
                                "assets/images/profile/first_name_icon.png",
                                "Enter Your First Name",
                                "First Name"),
                            SizedBox(
                              height: querySize.height * 0.03,
                            ),
                            editProfileField(
                                context,
                                "assets/images/profile/second_name_icon.png",
                                "Enter Your Last Name",
                                "Last Name"),
                            SizedBox(
                              height: querySize.height * 0.03,
                            ),
                            editProfileField(
                                context,
                                "assets/images/profile/email_icon.png",
                                "Enter Your Email",
                                "Email"),
                            SizedBox(
                              height: querySize.height * 0.03,
                            ),
                            editProfileField(
                                context,
                                "assets/images/profile/qid_icon.png",
                                "QID No",
                                "QID/ Passport"),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: querySize.height * 0.062,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00ACB3),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedGender,
                                            hint: const Row(
                                              children: [
                                                SizedBox(width: 8),
                                                Text(
                                                  'Choose Gender',
                                                  style: TextStyle(
                                                      color: Color(0xFFD0D0D0)),
                                                ),
                                              ],
                                            ),
                                            dropdownColor: Colors.white,
                                            menuMaxHeight:
                                                querySize.height * 0.2,
                                            items: genderOptions
                                                .map((String gender) {
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
                            customSizedBox(querySize),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                editProfileButtonWidget(querySize, 'Cancel',
                                    Colors.white, const Color(0xFF00ACB3)),
                                editProfileButtonWidget(querySize, 'Save',
                                    const Color(0xFF00ACB3), Colors.white),
                              ],
                            ),
                            customSizedBox(querySize),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: querySize.height * 0.02,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
              child: customProfileTopBar(querySize, context, 'Edit Profile'),
            ),
          ),
        ],
      )),
    );
  }

  ElevatedButton editProfileButtonWidget(
      Size querySize, String buttonText, Color buttonColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: Size(
          querySize.width * (137 / 375),
          querySize.height * (42 / 812),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: const Color(0xFF00ACB3),
            width: querySize.width * 0.004,
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
