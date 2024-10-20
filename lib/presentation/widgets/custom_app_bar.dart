import 'package:flutter/material.dart';

class CustomAppABr extends StatelessWidget {
  const CustomAppABr({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.07),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: querySize.width * 0.07, // Adjust the width
              height: querySize.width * 0.07, // Adjust the height
              child: Image.asset(
                'assets/images/back_button.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add action for cart button tap here
            },
            child: Container(
              width: querySize.width * 0.07,
              height: querySize.width * 0.07, // Use width for square dimensions
              child: Image.asset(
                'assets/images/bag-2.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
