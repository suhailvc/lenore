import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/qid_widget.dart';

import 'package:provider/provider.dart';
import 'package:lenore/application/provider/edit_profile_provider/edit_profile_provider.dart';
import 'package:lenore/domain/profile_model/profile_model.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/edit_profile_field.dart';
import 'package:lenore/core/constant.dart';

// class EditProfileScreen extends StatefulWidget {
//   final ProfileData profileData;
//   const EditProfileScreen({required this.profileData, super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var nameContoller = TextEditingController(text: widget.profileData.fName);
//     var lastNameContoller =
//         TextEditingController(text: widget.profileData.lName);
//     var emailContoller = TextEditingController(text: widget.profileData.email);
//     String gender = widget.profileData.gender;
//     var querySize = MediaQuery.of(context).size;
//     List<String> genderOptions = ['Male', 'Female'];
//     String? selectedGender;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: querySize.height * 0.07),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: querySize.width * 0.05),
//                 child: Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: querySize.width * 0.02),
//                   child: Column(
//                     children: [
//                       customHeightThree(querySize),
//                       CircleAvatar(
//                         radius: querySize.width * 0.13,
//                         foregroundImage: const AssetImage(
//                           'assets/images/profile/profile_picture_image.png',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       Text(
//                         "Edit Profile",
//                         style: TextStyle(
//                           color: const Color(0xFF00ACB3),
//                           fontSize: querySize.height * 0.022,
//                           fontFamily: 'Segoe',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       SizedBox(
//                         height: querySize.height * 0.02,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.04),
//                         child: Column(
//                           children: [
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/first_name_icon.png",
//                                 "Enter Your First Name",
//                                 "First Name",
//                                 nameContoller),
//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/second_name_icon.png",
//                                 "Enter Your Last Name",
//                                 "Last Name",
//                                 lastNameContoller),
//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/email_icon.png",
//                                 "Enter Your Email",
//                                 "Email",
//                                 emailContoller),
//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Gender",
//                                   style: TextStyle(
//                                     fontFamily: 'Jost',
//                                     color: appColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: querySize.height * 0.01,
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16),
//                                   height: querySize.height * 0.062,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: const Color(0xFF00ACB3),
//                                         width: 1.5),
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<String>(
//                                             isExpanded: true,
//                                             value: selectedGender,
//                                             hint: Row(
//                                               children: [
//                                                 SizedBox(width: 8),
//                                                 Text(
//                                                   gender == "1"
//                                                       ? 'male'
//                                                       : 'female',
//                                                   style: TextStyle(
//                                                       color: Color(0xFFD0D0D0)),
//                                                 ),
//                                               ],
//                                             ),
//                                             dropdownColor: Colors.white,
//                                             menuMaxHeight:
//                                                 querySize.height * 0.2,
//                                             items: genderOptions
//                                                 .map((String gender) {
//                                               return DropdownMenuItem<String>(
//                                                 value: gender,
//                                                 child: Text(gender),
//                                               );
//                                             }).toList(),
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 selectedGender = newValue;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             customSizedBox(querySize),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 editProfileButtonWidget(
//                                     querySize,
//                                     'Cancel',
//                                     Colors.white,
//                                     const Color(0xFF00ACB3),
//                                     nameContoller.text.trim(),
//                                     lastNameContoller.text.trim(),
//                                     emailContoller.text.trim(),
//                                     gender),
//                                 editProfileButtonWidget(
//                                     querySize,
//                                     'Save',
//                                     const Color(0xFF00ACB3),
//                                     Colors.white,
//                                     nameContoller.text.trim(),
//                                     lastNameContoller.text.trim(),
//                                     emailContoller.text.trim(),
//                                     gender),
//                               ],
//                             ),
//                             customSizedBox(querySize),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: querySize.height * 0.02,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//               child: customProfileTopBar(querySize, context, 'Edit Profile'),
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   ElevatedButton editProfileButtonWidget(
//       Size querySize,
//       String buttonText,
//       Color buttonColor,
//       Color textColor,
//       String fname,
//       String sName,
//       String email,
//       String gender) {
//     return ElevatedButton(
//       onPressed: () async {
//         if (buttonText == 'Save') {
//           final success =
//               await Provider.of<EditProfileProvider>(context, listen: false)
//                   .editProfileRequest(
//                       fName: fname.trim(),
//                       email: email.trim(),
//                       gender: gender,
//                       lName: sName.trim());

//           // Displaying SnackBar based on success response
//           if (success) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("Profile updated successfully!"),
//                 backgroundColor: Colors.green,
//                 duration: Duration(seconds: 2),
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("Failed to update profile."),
//                 backgroundColor: Colors.red,
//                 duration: Duration(seconds: 2),
//               ),
//             );
//           }
//         } else {
//           Navigator.pop(context); // For Cancel button
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor,
//         minimumSize: Size(
//           querySize.width * (137 / 375),
//           querySize.height * (42 / 812),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(
//             color: const Color(0xFF00ACB3),
//             width: querySize.width * 0.004,
//           ),
//         ),
//       ),
//       child: Text(
//         buttonText,
//         style: TextStyle(color: textColor),
//       ),
//     );
//   }
// }

class EditProfileScreen extends StatefulWidget {
  final ProfileData profileData;
  const EditProfileScreen({required this.profileData, Key? key})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController qidController;
  late TextEditingController phoneController;
  String selectedGender = '1'; // Default to 'Male' (1)
  List<String> genderOptions = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileData.fName);
    lastNameController = TextEditingController(text: widget.profileData.lName);
    emailController = TextEditingController(text: widget.profileData.email);
    qidController = TextEditingController(text: widget.profileData.qId);
    phoneController = TextEditingController(text: widget.profileData.phone);
  }

  Future<void> _pickImage(
      BuildContext context, EditProfileProvider provider) async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Gallery"),
            onTap: () {
              provider.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
            onTap: () {
              provider.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    var editProfileProvider = Provider.of<EditProfileProvider>(context);

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
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: querySize.width * 0.13,
                        backgroundImage:
                            editProfileProvider.selectedImage != null
                                ? FileImage(editProfileProvider.selectedImage!)
                                : AssetImage("assets/images/avatar.png")
                                    as ImageProvider,
                      ),
                      SizedBox(
                        height: querySize.height * 0.008,
                      ),
                      GestureDetector(
                        onTap: () => _pickImage(context, editProfileProvider),
                        child: Container(
                          width: querySize.width * 0.2,
                          height: querySize.height * 0.02,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.02),
                          ),
                          child: Center(
                            child: Text(
                              "Choose Image",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: querySize.height * 0.01),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: appColor,
                      //     minimumSize: Size(90, 00),
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 16, vertical: 12),
                      //   ),
                      //   onPressed: () =>
                      //       _pickImage(context, editProfileProvider),
                      //   child: Text(
                      //     "Choose Image",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // SizedBox(height: querySize.height * 0.02),
                      // Text(
                      //   "Edit Profile",
                      //   style: TextStyle(
                      //     color: const Color(0xFF00ACB3),
                      //     fontSize: querySize.height * 0.022,
                      //     fontFamily: 'Segoe',
                      //   ),
                      // ),
                      SizedBox(height: querySize.height * 0.03),
                      editProfileField(
                        context,
                        "assets/images/profile/first_name_icon.png",
                        "Enter Your First Name",
                        "First Name",
                        nameController,
                      ),
                      SizedBox(height: querySize.height * 0.03),
                      editProfileField(
                        context,
                        "assets/images/profile/second_name_icon.png",
                        "Enter Your Last Name",
                        "Last Name",
                        lastNameController,
                      ),
                      SizedBox(height: querySize.height * 0.03),
                      qidField(
                        context,
                        "assets/images/profile/email_icon.png",
                        "Enter Your QID",
                        "QID/PASSPORT",
                        qidController,
                      ),
                      SizedBox(height: querySize.height * 0.03),
                      qidField(
                        context,
                        "assets/images/profile/qatar_flag_icon.png",
                        "Enter Your Email",
                        "Mobile Number",
                        phoneController,
                      ),
                      SizedBox(height: querySize.height * 0.03),
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
                            height: querySize.height * 0.062,
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
                                      hint: Text(
                                        selectedGender == "1"
                                            ? 'Male'
                                            : 'Female',
                                        style:
                                            TextStyle(color: Color(0xFFD0D0D0)),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                            value: '1', child: Text('Male')),
                                        DropdownMenuItem(
                                            value: '0', child: Text('Female')),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGender = newValue ?? '1';
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
                      SizedBox(height: querySize.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          editProfileButtonWidget(
                            querySize,
                            'Cancel',
                            Colors.white,
                            const Color(0xFF00ACB3),
                          ),
                          editProfileButtonWidget(
                            querySize,
                            'Save',
                            const Color(0xFF00ACB3),
                            Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: querySize.height * 0.03),
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
                child: customProfileTopBar(querySize, context, 'Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton editProfileButtonWidget(
      Size querySize, String buttonText, Color buttonColor, Color textColor) {
    return ElevatedButton(
      onPressed: () async {
        if (buttonText == 'Save') {
          final token = await Provider.of<AuthProvider>(context, listen: false)
              .getToken();
          print("token $token");
          final success =
              await Provider.of<EditProfileProvider>(context, listen: false)
                  .editProfileRequest(
            fName: nameController.text.trim(),
            email: emailController.text.trim(),
            gender: selectedGender,
            lName: lastNameController.text.trim(),
            token: token!,
          );

          if (success) {
            // Show SnackBar on success
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Profile updated successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            await Provider.of<ProfileProvider>(context, listen: false)
                .fetchProfile(token);
          } else {
            // Show error SnackBar if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to update profile."),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: Size(querySize.width * 0.4, querySize.height * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: appColor, // Set your desired border color here
            width: 2, // Set the border width if needed
          ),
        ),
      ),
      child: Text(buttonText, style: TextStyle(color: textColor)),
    );
  }

  // ElevatedButton editProfileButtonWidget(
  //     Size querySize, String buttonText, Color buttonColor, Color textColor) {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       if (buttonText == 'Save') {
  //         final token = await Provider.of<AuthProvider>(context, listen: false)
  //             .getToken();
  //         Provider.of<EditProfileProvider>(context, listen: false)
  //             .editProfileRequest(
  //           fName: nameController.text.trim(),
  //           email: emailController.text.trim(),
  //           gender: selectedGender,
  //           lName: lastNameController.text.trim(),
  //           token: token!,
  //         );
  //       } else {
  //         Navigator.pop(context);
  //       }
  //     },
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: buttonColor,
  //       minimumSize: Size(querySize.width * 0.4, querySize.height * 0.05),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //     ),
  //     child: Text(buttonText, style: TextStyle(color: textColor)),
  //   );
  // }
}
// import 'package:flutter/material.dart';

// import 'package:lenore/application/provider/edit_profile_provider/edit_profile_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/domain/profile_model/profile_model.dart';

// import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
// import 'package:lenore/presentation/screens/profile_screen.dart/widget/edit_profile_field.dart';
// import 'package:provider/provider.dart';

// class EditProfileScreen extends StatefulWidget {
//   final ProfileData profileData;
//   const EditProfileScreen({required this.profileData, super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var nameContoller = TextEditingController(text: widget.profileData.fName);
//     // nameContoller = widget.profileData.fName;
//     var lastNameContoller =
//         TextEditingController(text: widget.profileData.lName);
//     var emailContoller = TextEditingController(text: widget.profileData.email);
//     String gender = widget.profileData.gender;
//     var querySize = MediaQuery.of(context).size;
//     List<String> genderOptions = ['Male', 'Female'];
//     String? selectedGender;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: querySize.height * 0.07),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: querySize.width * 0.05),
//                 child: Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: querySize.width * 0.02),
//                   child: Column(
//                     children: [
//                       customHeightThree(querySize),
//                       CircleAvatar(
//                         radius: querySize.width * 0.13,
//                         foregroundImage: const AssetImage(
//                           'assets/images/profile/profile_picture_image.png',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       Text(
//                         "Edit Profile",
//                         style: TextStyle(
//                           color: const Color(0xFF00ACB3),
//                           fontSize: querySize.height * 0.022,
//                           fontFamily: 'Segoe',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       SizedBox(
//                         height: querySize.height * 0.02,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.04),
//                         child: Column(
//                           children: [
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/first_name_icon.png",
//                                 "Enter Your First Name",
//                                 "First Name",
//                                 nameContoller),

//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/second_name_icon.png",
//                                 "Enter Your Last Name",
//                                 "Last Name",
//                                 lastNameContoller),
//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             editProfileField(
//                                 context,
//                                 "assets/images/profile/email_icon.png",
//                                 "Enter Your Email",
//                                 "Email",
//                                 emailContoller),
//                             // SizedBox(
//                             //   height: querySize.height * 0.03,
//                             // ),
//                             // editProfileField(
//                             //     context,
//                             //     "assets/images/profile/qid_icon.png",
//                             //     "QID No",
//                             //     "QID/ Passport"),
//                             SizedBox(
//                               height: querySize.height * 0.03,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Gender",
//                                   style: TextStyle(
//                                     fontFamily: 'Jost',
//                                     color: appColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: querySize.height * 0.01,
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16),
//                                   height: querySize.height * 0.062,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: const Color(0xFF00ACB3),
//                                         width: 1.5),
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<String>(
//                                             isExpanded: true,
//                                             value: selectedGender,
//                                             hint: Row(
//                                               children: [
//                                                 SizedBox(width: 8),
//                                                 Text(
//                                                   gender == "1"
//                                                       ? 'male'
//                                                       : 'female',
//                                                   style: TextStyle(
//                                                       color: Color(0xFFD0D0D0)),
//                                                 ),
//                                               ],
//                                             ),
//                                             dropdownColor: Colors.white,
//                                             menuMaxHeight:
//                                                 querySize.height * 0.2,
//                                             items: genderOptions
//                                                 .map((String gender) {
//                                               return DropdownMenuItem<String>(
//                                                 value: gender,
//                                                 child: Text(gender),
//                                               );
//                                             }).toList(),
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 selectedGender = newValue;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             customSizedBox(querySize),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 editProfileButtonWidget(
//                                     querySize,
//                                     'Cancel',
//                                     Colors.white,
//                                     const Color(0xFF00ACB3),
//                                     nameContoller.text.trim(),
//                                     lastNameContoller.text.trim(),
//                                     emailContoller.text.trim(),
//                                     gender),
//                                 editProfileButtonWidget(
//                                     querySize,
//                                     'Save',
//                                     const Color(0xFF00ACB3),
//                                     Colors.white,
//                                     nameContoller.text.trim(),
//                                     lastNameContoller.text.trim(),
//                                     emailContoller.text.trim(),
//                                     gender),
//                               ],
//                             ),
//                             customSizedBox(querySize),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: querySize.height * 0.02,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//               child: customProfileTopBar(querySize, context, 'Edit Profile'),
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   ElevatedButton editProfileButtonWidget(
//       Size querySize,
//       String buttonText,
//       Color buttonColor,
//       Color textColor,
//       String fname,
//       String sName,
//       String email,
//       String gender) {
//     return ElevatedButton(
//       onPressed: () {
//         if (buttonText == 'Save') {
//           Provider.of<EditProfileProvider>(context, listen: false)
//               .editProfileRequest(
//                   fName: fname.trim(),
//                   email: email.trim(),
//                   gender: '1',
//                   lName: sName.trim());
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor,
//         minimumSize: Size(
//           querySize.width * (137 / 375),
//           querySize.height * (42 / 812),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(
//             color: const Color(0xFF00ACB3),
//             width: querySize.width * 0.004,
//           ),
//         ),
//       ),
//       child: Text(
//         buttonText,
//         style: TextStyle(color: textColor),
//       ),
//     );
//   }
// }
