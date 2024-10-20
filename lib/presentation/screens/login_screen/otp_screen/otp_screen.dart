import 'package:flutter/material.dart';
import 'package:lenore/application/provider/login_provider/login_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/login_screen/personal_details_screen/personal_details_screen.dart';
import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    // Start the OTP timer countdown
    Provider.of<TimerProvider>(context, listen: false).startTimer();
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
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'serif',
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Code has been sent to ',
                    ),
                    TextSpan(
                      text: '+974 3322 5566',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF00ACB3), // Custom color
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
                    _otpTextField(context, first: true, last: false),
                    _otpTextField(context, first: false, last: false),
                    _otpTextField(context, first: false, last: false),
                    _otpTextField(context, first: false, last: true),
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
                        '${timerProvider.start} seconds', // Countdown
                        // Show option to resend OTP
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
              const Spacer(),
              loginCustomButton(
                context,
                querySize,
                "CONTINUE",
                const PersonalDetailsScreen(),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _otpTextField(BuildContext context,
    {required bool first, required bool last}) {
  return Container(
    width: 77,
    height: 55,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
      borderRadius: BorderRadius.circular(28),
    ),
    child: TextFormField(
      autofocus: true,
      obscureText: true,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
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

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});

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
//               const SizedBox(
//                 height: 60,
//               ),
//               const Text(
//                 'Enter Your OTP to Continue',
//                 style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Lora'),
//               ),
//               const SizedBox(height: 20),
//               RichText(
//                 text: const TextSpan(
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'serif',
//                     color: Colors.black, // Default color
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'Code has been sent to ',
//                     ),
//                     TextSpan(
//                       text: '+974 3322 5566',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Color(
//                               0xFF00ACB3)), // Change to your preferred color
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Form(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _otpTextField(context, first: true, last: false),
//                     _otpTextField(context, first: false, last: false),
//                     _otpTextField(context, first: false, last: false),
//                     _otpTextField(context, first: false, last: true),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     'Resend OTP?',
//                     style: TextStyle(
//                         fontFamily: 'Jost',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: appColor),
//                   ),
//                   Consumer<TimerProvider>(
//                     builder: (context, timerProvider, child) {
//                       return Text(
//                         timerProvider.start > 0
//                             ? ' in ${timerProvider.start} seconds' // Display the countdown
//                             : '', // Show nothing or "Resend now" when countdown finishes
//                         style: TextStyle(
//                           fontFamily: 'Jost',
//                           fontSize: 11,
//                           fontWeight: FontWeight.w500,
//                           color: appColor,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               loginCustomButton(context, querySize, "CONTINUE",
//                   const PersonalDetailsScreen()),
//               const SizedBox(
//                 height: 70,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _otpTextField(BuildContext context,
//     {required bool first, required bool last}) {
//   return Container(
//     width: 77,
//     height: 55,
//     decoration: BoxDecoration(
//       border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
//       borderRadius: BorderRadius.circular(28),
//     ),
//     child: TextFormField(
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
