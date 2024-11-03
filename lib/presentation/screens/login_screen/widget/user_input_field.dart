import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Container userInputField({required TextEditingController inputController}) {
  return Container(
    height: 55,
    width: 333,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset("assets/images/mobile.png"),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '+974',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                  8), // Limits input to 8 characters
              FilteringTextInputFormatter.digitsOnly, // Allows only digits
            ],
            controller: inputController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
              border: InputBorder.none,
              hintText: 'Mobile Number',
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ],
    ),
  );
}
