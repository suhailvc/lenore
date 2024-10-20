import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/edit_profile_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/user_detail_column.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: querySize.height * 0.07),
              child: SingleChildScrollView(
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
                        "My Profile",
                        style: TextStyle(
                          color: const Color(0xFF00ACB3),
                          fontSize: querySize.height * 0.022,
                          fontFamily: 'Segoe',
                        ),
                      ),
                      customSizedBox(querySize),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: querySize.width * 0.07),
                        child: Column(
                          children: [
                            userDetailColumn(
                              context: context,
                              assetName:
                                  "assets/images/profile/first_name_icon.png",
                              columnHeading: 'First Name',
                              columnName: 'Mehrab',
                            ),
                            customSizedBox(querySize),
                            userDetailColumn(
                              context: context,
                              assetName:
                                  "assets/images/profile/second_name_icon.png",
                              columnHeading: 'Last Name',
                              columnName: 'ABCD',
                            ),
                            customSizedBox(querySize),
                            userDetailColumn(
                              context: context,
                              assetName: "assets/images/profile/email_icon.png",
                              columnHeading: 'Email ID',
                              columnName: 'abcd@gmail.com',
                            ),
                            customSizedBox(querySize),
                            userDetailColumn(
                              context: context,
                              assetName:
                                  "assets/images/profile/qatar_flag_icon.png",
                              columnHeading: 'Mobile Number',
                              columnName: '+974 3652145',
                            ),
                            customSizedBox(querySize),
                            userDetailColumn(
                              context: context,
                              assetName: "assets/images/profile/qid_icon.png",
                              columnHeading: 'QID/ PASSPORT',
                              columnName: '173652145',
                            ),
                            customSizedBox(querySize),
                            userDetailColumn(
                              context: context,
                              assetName: "assets/images/profile/qid_icon.png",
                              columnHeading: 'Gender',
                              columnName: 'MALE',
                            ),
                            customSizedBox(querySize),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen(),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00ACB3),
                                minimumSize: Size(
                                  querySize.width * (137 / 375),
                                  querySize.height * (42 / 812),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            customSizedBox(querySize),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: querySize.height * 0.02,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                child: customProfileTopBar(
                    querySize, context, 'Profile'), // Your custom top bar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
