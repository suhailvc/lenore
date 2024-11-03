import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/edit_profile_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/user_detail_column.dart';
import 'package:lenore/presentation/widgets/sign_out_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _fetchProfile();
    super.initState();
  }

  Future<void> _fetchProfile() async {
    final authProvider =
        await Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    if (token != null) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile(token);
    }
  }

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
                    padding: EdgeInsets.symmetric(
                        horizontal: querySize.width * 0.02),
                    child: Consumer<ProfileProvider>(
                      builder: (context, profileValue, child) {
                        if (profileValue.showGif) {
                          return lenoreGif(querySize);
                        }
                        if (profileValue.profile == null) {
                          return askSignIn(querySize);
                        }
                        print(profileValue.profile!.data.image);
                        return Column(
                          children: [
                            customHeightThree(querySize),
                            CircleAvatar(
                              radius: querySize.width * 0.13,
                              foregroundImage:
                                  profileValue.profile!.data.image != null
                                      ? NetworkImage(
                                          profileValue.profile!.data.image!)
                                      : AssetImage(
                                          "assets/images/avatar.png",
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
                                    columnName:
                                        profileValue.profile!.data.fName,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/second_name_icon.png",
                                    columnHeading: 'Last Name',
                                    columnName:
                                        profileValue.profile!.data.lName ?? '',
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/email_icon.png",
                                    columnHeading: 'Email ID',
                                    columnName:
                                        profileValue.profile!.data.email,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qatar_flag_icon.png",
                                    columnHeading: 'Mobile Number',
                                    columnName:
                                        '+974 ${profileValue.profile!.data.phone}',
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qid_icon.png",
                                    columnHeading: 'QID/ PASSPORT',
                                    columnName: profileValue.profile!.data.qId,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qid_icon.png",
                                    columnHeading: 'Gender',
                                    columnName:
                                        profileValue.profile!.data.gender == '1'
                                            ? 'Male'
                                            : 'Female',
                                  ),
                                  customSizedBox(querySize),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfileScreen(
                                                    profileData: profileValue
                                                        .profile!.data),
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
                        );
                      },
                    )),
              ),
            ),
            Positioned(
              top: querySize.height * 0.02,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                child: customProfileTopBar(querySize, context, 'Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     _fetchProfile();
//     super.initState();
//   }

//   Future<void> _fetchProfile() async {
//     final authProvider =
//         await Provider.of<AuthProvider>(context, listen: false);
//     final token = await authProvider.getToken();

//     if (token != null) {
//       Provider.of<ProfileProvider>(context, listen: false).fetchProfile(token);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: querySize.height * 0.07),
//               child: SingleChildScrollView(
//                 child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: querySize.width * 0.02),
//                     child: Consumer<ProfileProvider>(
//                       builder: (context, profileValue, child) {
//                         if (profileValue.showGif) {
//                           return lenoreGif(querySize);
//                         }
//                         if (profileValue.profile == null) {
//                           return SizedBox();
//                         }
//                         print(profileValue.profile!.data.image!);
//                         return Column(
//                           children: [
//                             customHeightThree(querySize),
//                             CircleAvatar(
//                               radius: querySize.width * 0.13,
//                               foregroundImage:
//                                   profileValue.profile!.data.image != null
//                                       ? NetworkImage(
//                                           profileValue.profile!.data.image!)
//                                       : AssetImage(
//                                           'assets/images/profile/profile_picture_image.png',
//                                         ),
//                             ),
//                             customSizedBox(querySize),
//                             Text(
//                               "My Profile",
//                               style: TextStyle(
//                                 color: const Color(0xFF00ACB3),
//                                 fontSize: querySize.height * 0.022,
//                                 fontFamily: 'Segoe',
//                               ),
//                             ),
//                             customSizedBox(querySize),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: querySize.width * 0.07),
//                               child: Column(
//                                 children: [
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/first_name_icon.png",
//                                     columnHeading: 'First Name',
//                                     columnName:
//                                         profileValue.profile!.data.fName,
//                                   ),
//                                   customSizedBox(querySize),
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/second_name_icon.png",
//                                     columnHeading: 'Last Name',
//                                     columnName:
//                                         profileValue.profile!.data.lName == null
//                                             ? ""
//                                             : profileValue.profile!.data.lName!,
//                                   ),
//                                   customSizedBox(querySize),
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/email_icon.png",
//                                     columnHeading: 'Email ID',
//                                     columnName:
//                                         profileValue.profile!.data.email,
//                                   ),
//                                   customSizedBox(querySize),
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/qatar_flag_icon.png",
//                                     columnHeading: 'Mobile Number',
//                                     columnName:
//                                         '+974 ${profileValue.profile!.data.phone}',
//                                   ),
//                                   customSizedBox(querySize),
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/qid_icon.png",
//                                     columnHeading: 'QID/ PASSPORT',
//                                     columnName: profileValue.profile!.data.qId,
//                                   ),
//                                   customSizedBox(querySize),
//                                   userDetailColumn(
//                                     context: context,
//                                     assetName:
//                                         "assets/images/profile/qid_icon.png",
//                                     columnHeading: 'Gender',
//                                     columnName:
//                                         profileValue.profile!.data.gender == '1'
//                                             ? 'Male'
//                                             : "female",
//                                   ),
//                                   customSizedBox(querySize),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 EditProfileScreen(
//                                                     profileData: profileValue
//                                                         .profile!.data),
//                                           ));
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: const Color(0xFF00ACB3),
//                                       minimumSize: Size(
//                                         querySize.width * (137 / 375),
//                                         querySize.height * (42 / 812),
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Edit Profile',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                   customSizedBox(querySize),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     )),
//               ),
//             ),
//             Positioned(
//               top: querySize.height * 0.02,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//                 child: customProfileTopBar(querySize, context, 'Profile'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
