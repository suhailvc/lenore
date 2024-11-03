import 'package:flutter/material.dart';

import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/user_registration_model/user_registration_success_model.dart';

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
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qIdController = TextEditingController();
  String? selectedGender;
  bool termsAccepted = false;
  bool showTermsError = false;

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
                    if (provider.errors?.email == null &&
                        fNameController.text.isEmpty)
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
                    if (provider.errors?.email != null)
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
                    if (provider.errors?.qId != null)
                      errorText(provider.errors!.qId!.first),
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
                                        value: gender == 'Male'
                                            ? '1'
                                            : '2', // Map gender to '1' or '2'
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
                        if (selectedGender == null)
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
                              showTermsError =
                                  !termsAccepted; // Hide error if accepted
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
                    if (showTermsError)
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
                            if (!termsAccepted) {
                              setState(() => showTermsError = true);
                              return; // Stop submission if terms not accepted
                            }
                            var response = await provider.userRegistration(
                              context: context,
                              fName: fNameController.text.trim(),
                              sName: lNameController.text.trim(),
                              email: emailController.text.trim(),
                              qId: qIdController.text.trim(),
                              gender: selectedGender ??
                                  '', // Pass '1' or '2' based on selection
                              term: termsAccepted,
                              mobileNumber: widget.mobileNumber,
                            );
                            if (response is UserRegistrationSuccessModel) {
                              // Clear the fields
                              fNameController.clear();
                              lNameController.clear();
                              emailController.clear();
                              qIdController.clear();
                              setState(() {
                                selectedGender = null;
                                termsAccepted = false;
                              });

                              // Navigate to the PersistantBottomNavBarScreen
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

  // Error Text Widget
  Widget errorText(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    qIdController.dispose();
    super.dispose();
  }
}

// class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
//   TextEditingController fNameController = TextEditingController();
//   TextEditingController lNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController qIdController = TextEditingController();
//   String? selectedGender;
//   bool termsAccepted = false;

//   List<String> genderOptions = ['Male', 'Female'];

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Consumer<UserRegistrationProvider>(
//               builder: (context, provider, child) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: querySize.height * 0.05),
//                     const Text(
//                       'Welcome to Lenore',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Lora'),
//                     ),
//                     SizedBox(height: querySize.height * 0.01),
//                     const Text(
//                       'Enter Your Personal Details',
//                       style: TextStyle(
//                           fontSize: 36,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Lora'),
//                     ),
//                     SizedBox(height: querySize.height * 0.02),

//                     // First Name Field
//                     userInputField(
//                       context,
//                       "assets/images/profile.png",
//                       "Enter Your First Name",
//                       "First Name",
//                       fNameController,
//                     ),
//                     if (provider.errors?.email == null &&
//                         fNameController.text.isEmpty)
//                       errorText("First name is required"),
//                     SizedBox(height: querySize.height * 0.03),

//                     // Last Name Field
//                     userInputField(
//                       context,
//                       "assets/images/profile.png",
//                       "Enter Your Last Name",
//                       "Last Name",
//                       lNameController,
//                     ),
//                     SizedBox(height: querySize.height * 0.03),

//                     // Email Field
//                     userInputField(
//                       context,
//                       "assets/images/email.png",
//                       "Enter Your Email",
//                       "Email",
//                       emailController,
//                     ),
//                     if (provider.errors?.email != null)
//                       errorText(provider.errors!.email!.first),
//                     SizedBox(height: querySize.height * 0.03),

//                     // QID Field
//                     userInputField(
//                       context,
//                       "assets/images/flag_qatar.png",
//                       "QID No",
//                       "QID/ Passport",
//                       qIdController,
//                     ),
//                     if (provider.errors?.qId != null)
//                       errorText(provider.errors!.qId!.first),
//                     SizedBox(height: querySize.height * 0.03),

//                     // Gender Dropdown
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Gender",
//                           style: TextStyle(
//                             fontFamily: 'Jost',
//                             color: appColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(height: querySize.height * 0.01),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           height: querySize.height * 0.07,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: const Color(0xFF00ACB3), width: 1.5),
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: selectedGender,
//                                     hint: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(
//                                               querySize.height * 0.001),
//                                           child: Image.asset(
//                                             "assets/images/profile.png",
//                                             width: querySize.width * 0.08,
//                                             height: querySize.height * 0.04,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         const Text(
//                                           'Choose Gender',
//                                           style: TextStyle(
//                                               color: Color(0xFFD0D0D0)),
//                                         ),
//                                       ],
//                                     ),
//                                     icon: Image.asset(
//                                       "assets/images/down_arrow.png",
//                                       width: querySize.width * 0.08,
//                                       height: querySize.height * 0.04,
//                                     ),
//                                     dropdownColor: Colors.white,
//                                     menuMaxHeight: querySize.height * 0.2,
//                                     items: genderOptions.map((String gender) {
//                                       return DropdownMenuItem<String>(
//                                         value: gender == 'Male' ? '1' : '2',
//                                         child: Text(gender),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         selectedGender = newValue;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (selectedGender == null)
//                           errorText("Gender is required"),
//                       ],
//                     ),
//                     SizedBox(height: querySize.height * 0.02),

//                     // Terms and Conditions Checkbox
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: termsAccepted,
//                           onChanged: (value) =>
//                               setState(() => termsAccepted = value ?? false),
//                         ),
//                         Text(
//                           "I have read and agree to terms and conditions",
//                           style: TextStyle(
//                             fontSize: querySize.width * 0.031,
//                             color: appColor,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Segoe',
//                           ),
//                         )
//                       ],
//                     ),
//                     customSizedBox(querySize),
//                     Text(
//                       "Note : Our team will contact you to confirm the ID number / Passport number",
//                       style: TextStyle(
//                         fontSize: querySize.width * 0.031,
//                         color: const Color(0xFF7F7F7F),
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Segoe',
//                       ),
//                     ),
//                     SizedBox(height: querySize.height * 0.05),

//                     // Continue Button
//                     provider.isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : loginCustomButton(context, querySize, "CONTINUE", () {
//                             provider.userRegistration(
//                               fName: fNameController.text.trim(),
//                               sName: lNameController.text.trim(),
//                               email: emailController.text.trim(),
//                               qId: qIdController.text.trim(),
//                               gender: selectedGender ?? '',
//                               term: termsAccepted,
//                               mobileNumber: widget.mobileNumber,
//                             );
//                           }),
//                     SizedBox(height: querySize.height * 0.08),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Error Text Widget
//   Widget errorText(String errorMessage) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 4.0),
//       child: Text(
//         errorMessage,
//         style: const TextStyle(color: Colors.red, fontSize: 12),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     fNameController.dispose();
//     lNameController.dispose();
//     emailController.dispose();
//     qIdController.dispose();
//     super.dispose();
//   }
// }

// class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
//   TextEditingController fNameControlloer = TextEditingController();
//   TextEditingController lNameControlloer = TextEditingController();
//   TextEditingController emailControlloer = TextEditingController();
//   TextEditingController qIdControlloer = TextEditingController();
//   TextEditingController genderControlloer = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     List<String> genderOptions = ['Male', 'Female'];
//     String? selectedGender;
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: querySize.height * 0.05,
//                 ),
//                 const Text(
//                   'Welcome to Lenore',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'Lora'),
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.01,
//                 ),
//                 const Text(
//                   'Enter Your Personal Details',
//                   style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Lora'),
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.02,
//                 ),
//                 userInputField(context, "assets/images/profile.png",
//                     "Enter Your First Name", "First Name", fNameControlloer),
//                 SizedBox(
//                   height: querySize.height * 0.03,
//                 ),
//                 userInputField(context, "assets/images/profile.png",
//                     "Enter Your Last Name", "Last Name", lNameControlloer),
//                 SizedBox(
//                   height: querySize.height * 0.03,
//                 ),
//                 userInputField(context, "assets/images/email.png",
//                     "Enter Your Email", "Email", emailControlloer),
//                 SizedBox(
//                   height: querySize.height * 0.03,
//                 ),
//                 userInputField(context, "assets/images/flag_qatar.png",
//                     "QID No", "QID/ Passport", qIdControlloer),
//                 SizedBox(
//                   height: querySize.height * 0.03,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Gender",
//                       style: TextStyle(
//                         fontFamily: 'Jost',
//                         color: appColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(
//                       height: querySize.height * 0.01,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       height: querySize.height * 0.07,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: const Color(0xFF00ACB3), width: 1.5),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton<String>(
//                                 isExpanded: true,
//                                 value: selectedGender,
//                                 hint: Row(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.all(
//                                           querySize.height * 0.001),
//                                       child: Image.asset(
//                                         "assets/images/profile.png",
//                                         width: querySize.width * 0.08,
//                                         height: querySize.height * 0.04,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     const Text(
//                                       'Choose Gender',
//                                       style:
//                                           TextStyle(color: Color(0xFFD0D0D0)),
//                                     ),
//                                   ],
//                                 ),
//                                 icon: Image.asset(
//                                   "assets/images/down_arrow.png",
//                                   width: querySize.width * 0.08,
//                                   height: querySize.height * 0.04,
//                                 ),
//                                 dropdownColor: Colors.white,
//                                 menuMaxHeight: querySize.height * 0.2,
//                                 items: genderOptions.map((String gender) {
//                                   return DropdownMenuItem<String>(
//                                     value: gender,
//                                     child: Text(gender),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     selectedGender = newValue;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       visualDensity: VisualDensity.compact,
//                       activeColor: textColor,
//                       side: WidgetStateBorderSide.resolveWith(
//                         (states) => BorderSide(
//                           width: querySize.width * 0.003,
//                           color: textColor,
//                         ),
//                       ),
//                       value: false,
//                       onChanged: (value) {},
//                     ),
//                     Text(
//                       "I have read and agee to terms and conditions",
//                       style: TextStyle(
//                           fontSize: querySize.width * 0.031,
//                           color: appColor,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Segoe'),
//                     )
//                   ],
//                 ),
//                 customSizedBox(querySize),
//                 Text(
//                   "Note : Our team will contact you to confirm the ID number /\nPassport number",
//                   style: TextStyle(
//                       fontSize: querySize.width * 0.031,
//                       color: const Color(0xFF7F7F7F),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Segoe'),
//                 ),
//                 SizedBox(
//                   height: querySize.height * 0.05,
//                 ),
//                 Consumer<UserRegistrationProvider>(
//                     builder: (context, otpProvider, child) {
//                   return otpProvider.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : loginCustomButton(context, querySize, "CONTINUE", () {
//                           otpProvider.userRegistration(
//                               fName: fNameControlloer.text.trim(),
//                               sName: lNameControlloer.text.trim(),
//                               email: emailControlloer.text.trim(),
//                               qId: qIdControlloer.text.trim(),
//                               gender: 'male',
//                               term: true,
//                               mobileNumber: widget.mobileNumber);
//                         });
//                 }),
//                 SizedBox(
//                   height: querySize.height * 0.08,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     fNameControlloer.dispose();
//     lNameControlloer.dispose();
//     emailControlloer.dispose();
//     qIdControlloer.dispose();
//     genderControlloer.dispose();
//     super.dispose();
//   }
// }
