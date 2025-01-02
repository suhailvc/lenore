import 'package:flutter/material.dart';
import 'package:lenore/application/provider/mobile_number_provider/mobile_number_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/account_screen/widgets/whats_app.dart';
import 'package:lenore/presentation/screens/login_screen/otp_screen/otp_screen.dart';
import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:lenore/presentation/screens/login_screen/widget/user_input_field.dart';
import 'package:provider/provider.dart';

class MobileNumberInputScreen extends StatefulWidget {
  const MobileNumberInputScreen({super.key});

  @override
  _MobileNumberInputScreenState createState() =>
      _MobileNumberInputScreenState();
}

class _MobileNumberInputScreenState extends State<MobileNumberInputScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              const Text(
                'Enter Your Mobile Number',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lora',
                ),
              ),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              userInputField(inputController: _phoneController),
              const Spacer(),
              const Center(
                child: Text(
                  "We'll send a one-time OTP to verify your number",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Jost',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              Consumer<MobileNumberProvider>(
                builder: (context, apiService, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      String phoneNumber = _phoneController.text.trim();
                      if (phoneNumber.isNotEmpty) {
                        // Send mobile number using the API service
                        await apiService.sendMobileNumber(phoneNumber);

                        // Navigate to OTP screen if the API call is successful
                        if (apiService.resultMessage != null &&
                            apiService.resultMessage ==
                                'otp has been sent to the entered mobile number') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                mobileNumber: _phoneController.text.trim(),
                              ),
                            ),
                          );
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(apiService.resultMessage ?? 'Error'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a phone number"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(querySize.width * 0.85, querySize.height * 0.06),
                      backgroundColor: appColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: querySize.width * 0.15,
                        vertical: querySize.height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(querySize.width * 0.08),
                      ),
                    ),
                    child: Text(
                      'Get Otp',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Jost'),
                    ),
                  );
                },
              ),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              // Center(
              //   child: GestureDetector(
              //     onTap: () async {
              //       await openWhatsApp();
              //     },
              //     child: Text(
              //       "Need Help?",
              //       style: TextStyle(
              //         color: appColor,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: querySize.height * 0.08,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/login_screen/otp_screen/otp_screen.dart';
// import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
// import 'package:lenore/presentation/screens/login_screen/widget/user_input_field.dart';

// class MobileNumberInputScreen extends StatelessWidget {
//   const MobileNumberInputScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.07,
//               ),
//               const Text(
//                 'Enter Your Mobile Number',
//                 style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Lora'),
//               ),
//               SizedBox(
//                 height: querySize.height * 0.02,
//               ),
//               userInputField(),
//               const Spacer(),
//               const Center(
//                 child: Text(
//                   "We'll send a one-time OTP to verify your number",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: 'Jost'),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: querySize.height * 0.02,
//               ),
//               loginCustomButton(
//                   context, querySize, "GET OTP", const OtpScreen()),
//               SizedBox(
//                 height: querySize.height * 0.02,
//               ),
//               Center(
//                   child: Text(
//                 "Need Help?",
//                 style: TextStyle(
//                     color: appColor, fontSize: 16, fontWeight: FontWeight.w500),
//               )),
//               SizedBox(
//                 height: querySize.height * 0.08,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
