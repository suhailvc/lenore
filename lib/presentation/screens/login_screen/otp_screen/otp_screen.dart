import 'package:flutter/material.dart';
import 'package:lenore/application/provider/login_provider/login_provider.dart';
import 'package:lenore/application/provider/otp_provider/otp_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/otp_model/existing_user_otp_model.dart';
import 'package:lenore/domain/otp_model/new_user_otp_model.dart';
import 'package:lenore/presentation/screens/login_screen/personal_details_screen/personal_details_screen.dart';

import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({required this.mobileNumber, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TimerProvider>(context, listen: false).startTimer();
  }

  Future<void> _handleOtpSubmission(BuildContext context) async {
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    String otp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text;

    if (otp.isEmpty || otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    var response =
        await otpProvider.verifyOtp(widget.mobileNumber, otp, context);

    if (response is ExistingUserOtpModel) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PersistantBottomNavBarScreen()),
      );
    } else if (response is NewUserOtpModel) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PersonalDetailsScreen(mobileNumber: widget.mobileNumber)),
      );
    } else if (response is Map<String, dynamic> &&
        response.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['error'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Enter Your OTP to Continue',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lora',
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'serif',
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Code has been sent to '),
                    TextSpan(
                      text: widget.mobileNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF00ACB3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _otpTextField(context, otpController1,
                        first: true, last: false),
                    _otpTextField(context, otpController2,
                        first: false, last: false),
                    _otpTextField(context, otpController3,
                        first: false, last: false),
                    _otpTextField(context, otpController4,
                        first: false, last: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Resend OTP?',
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: appColor,
                    ),
                  ),
                  const Spacer(),
                  Consumer<TimerProvider>(
                    builder: (context, timerProvider, child) {
                      return Text(
                        '${timerProvider.start} seconds',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: querySize.height * 0.018,
                          fontWeight: FontWeight.w500,
                          color: Color(0x80292D32),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: querySize.height * 0.43,
              ),
              Consumer<OtpProvider>(
                builder: (context, otpProvider, child) {
                  return otpProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : loginCustomButton(
                          context,
                          querySize,
                          "CONTINUE",
                          () {
                            _handleOtpSubmission(context);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _otpTextField(BuildContext context, TextEditingController controller,
    {required bool first, required bool last}) {
  return Container(
    width: 77,
    height: 55,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
      borderRadius: BorderRadius.circular(28),
    ),
    child: TextFormField(
      maxLength: 1,
      controller: controller,
      autofocus: true,
      obscureText: true,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
        counterText: "", // Hides the character counter
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      ),
      onChanged: (value) {
        if (value.length == 1 && !last) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && !first) {
          FocusScope.of(context).previousFocus();
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a digit';
        }
        return null;
      },
    ),
  );
}

// class _OtpScreenState extends State<OtpScreen> {
//   final TextEditingController otpController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Start the OTP timer countdown
//     Provider.of<TimerProvider>(context, listen: false).startTimer();
//   }

//   Future<void> _handleOtpSubmission(BuildContext context) async {
//     final otpProvider = Provider.of<OtpProvider>(context, listen: false);
//     String otp = otpController.text;

//     // if (otp.isEmpty) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(content: Text('Please enter the OTP')),
//     //   );
//     //   return;
//     // }

//     var response = await otpProvider.verifyOtp(widget.mobileNumber, otp);

//     if (response is ExistingUserOtpModel) {
//       print('response');
//       // Navigate to Home Screen if the user exists
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => const PersistantBottomNavBarScreen()),
//       );
//     } else if (response is NewUserOtpModel) {
//       print(response);
//       // Navigate to Registration Screen for new users
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => PersonalDetailsScreen(
//                   mobileNumber: widget.mobileNumber,
//                 )),
//       );
//     } else if (response is Map<String, dynamic> &&
//         response.containsKey('error')) {
//       print(response);
//       print('ui error-------------------------------------------');
//       print(response);
//       // Show error message for incorrect OTP

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response['error'])),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 60),
//               const Text(
//                 'Enter Your OTP to Continue',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Lora',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'serif',
//                     color: Colors.black,
//                   ),
//                   children: <TextSpan>[
//                     const TextSpan(
//                       text: 'Code has been sent to ',
//                     ),
//                     TextSpan(
//                       text: widget.mobileNumber,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF00ACB3), // Custom color
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Form(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _otpTextField(context, otpController,
//                         first: true, last: false),
//                     _otpTextField(context, otpController,
//                         first: false, last: false),
//                     _otpTextField(context, otpController,
//                         first: false, last: false),
//                     _otpTextField(context, otpController,
//                         first: false, last: true),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     'Resend OTP?',
//                     style: TextStyle(
//                       fontFamily: 'Jost',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: appColor,
//                     ),
//                   ),
//                   const Spacer(),
//                   Consumer<TimerProvider>(
//                     builder: (context, timerProvider, child) {
//                       return Text(
//                         '${timerProvider.start} seconds',
//                         style: TextStyle(
//                           fontFamily: 'Segoe',
//                           fontSize: querySize.height * 0.018,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0x80292D32),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: querySize.height * 0.43,
//               ),
//               Consumer<OtpProvider>(
//                 builder: (context, otpProvider, child) {
//                   return otpProvider.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : loginCustomButton(
//                           context,
//                           querySize,
//                           "CONTINUE",
//                           () {
//                             _handleOtpSubmission(context);
//                           },
//                         );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _otpTextField(BuildContext context, TextEditingController otpController,
//     {required bool first, required bool last}) {
//   return Container(
//     width: 77,
//     height: 55,
//     decoration: BoxDecoration(
//       border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
//       borderRadius: BorderRadius.circular(28),
//     ),
//     child: TextFormField(
//       controller: otpController,
//       autofocus: true,
//       obscureText: true,
//       keyboardType: TextInputType.number,
//       textAlign: TextAlign.center,
//       style: const TextStyle(fontSize: 24),
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.all(10),
//       ),
//       onChanged: (value) {
//         if (value.length == 1 && !last) {
//           FocusScope.of(context).nextFocus();
//         }
//         if (value.isEmpty && !first) {
//           FocusScope.of(context).previousFocus();
//         }
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter a digit';
//         }
//         return null;
//       },
//     ),
//   );
// }



///-----------------------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:lenore/application/provider/otp_provider/otp_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/login_screen/personal_details_screen/personal_details_screen.dart';
// import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
// import 'package:provider/provider.dart';

// class OtpScreen extends StatefulWidget {
//   final String mobileNumber;

//   const OtpScreen({required this.mobileNumber, super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   late List<String> _otpValues;

//   @override
//   void initState() {
//     super.initState();
//     _otpValues = List.filled(4, ''); // Initialize OTP list with empty strings
//   }

//   void _verifyOtp(OtpProvider otpProvider) async {
//     String otp = _otpValues.join(); // Combine the entered OTP digits
//     if (otp.length == 4) {
//       await otpProvider.verifyOtp(widget.mobileNumber, otp);

//       if (otpProvider.errorMessage == null) {
//         // Success: Navigate to the PersonalDetailsScreen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const PersonalDetailsScreen(),
//           ),
//         );
//       } else {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(otpProvider.errorMessage ?? 'Error')),
//         );
//       }
//     } else {
//       // Show error if OTP is incomplete
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter the complete OTP')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 60),
//               const Text(
//                 'Enter Your OTP to Continue',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Lora',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Code has been sent to ${widget.mobileNumber}',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'serif',
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Form(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _otpTextField(context, first: true, last: false, index: 0),
//                     _otpTextField(context, first: false, last: false, index: 1),
//                     _otpTextField(context, first: false, last: false, index: 2),
//                     _otpTextField(context, first: false, last: true, index: 3),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Spacer(),
//               Consumer<OtpProvider>(
//                 builder: (context, otpProvider, child) {
//                   return ElevatedButton(
//                     onPressed: () {
//                       //  GoRouter.of(context).pushReplacement(NamedRoutes().home.path);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => screenName,
//                           ));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize:
//                           Size(querySize.width * 0.85, querySize.height * 0.06),
//                       backgroundColor: appColor,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: querySize.width * 0.15,
//                         vertical: querySize.height * 0.02,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(querySize.width * 0.08),
//                       ),
//                     ),
//                     child: Text(
//                       "Continue",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontFamily: 'Jost'),
//                     ),
//                   );
//                   // return loginCustomButton(
//                   //   context,
//                   //   querySize,
//                   //   otpProvider.isLoading ? "Verifying..." : "CONTINUE",
//                   //   null,
//                   //   onPressed: otpProvider.isLoading
//                   //       ? null
//                   //       : () =>
//                   //           _verifyOtp(otpProvider), // Call OTP verification
//                   // );
//                 },
//               ),
//               const SizedBox(height: 70),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _otpTextField(BuildContext context,
//       {required bool first, required bool last, required int index}) {
//     return Container(
//       width: 77,
//       height: 55,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: TextFormField(
//         autofocus: true,
//         obscureText: true,
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 24),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.all(10),
//         ),
//         onChanged: (value) {
//           if (value.length == 1 && !last) {
//             FocusScope.of(context).nextFocus();
//           }
//           if (value.isEmpty && !first) {
//             FocusScope.of(context).previousFocus();
//           }
//           _otpValues[index] = value; // Update OTP values
//         },
//       ),
//     );
//   }
// }

