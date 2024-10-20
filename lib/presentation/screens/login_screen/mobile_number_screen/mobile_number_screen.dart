import 'package:flutter/material.dart';

import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/login_screen/otp_screen/otp_screen.dart';
import 'package:lenore/presentation/screens/login_screen/widget/login_custom_button.dart';
import 'package:lenore/presentation/screens/login_screen/widget/user_input_field.dart';

class MobileNumberInputScreen extends StatelessWidget {
  const MobileNumberInputScreen({super.key});

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
                    fontFamily: 'Lora'),
              ),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              userInputField(),
              const Spacer(),
              const Center(
                child: Text(
                  "We'll send a one-time OTP to verify your number",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Jost'),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              loginCustomButton(
                  context, querySize, "GET OTP", const OtpScreen()),
              SizedBox(
                height: querySize.height * 0.02,
              ),
              Center(
                  child: Text(
                "Need Help?",
                style: TextStyle(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w500),
              )),
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
