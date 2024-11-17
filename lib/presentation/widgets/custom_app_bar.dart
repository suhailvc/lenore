import 'package:flutter/material.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
import 'package:provider/provider.dart';

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
          Consumer<CartProvider>(builder: (context, cartValue, child) {
            return Stack(
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/bag-2.png',
                    height: querySize.height * 0.035,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ));
                  },
                ),
                if (cartValue.items.isNotEmpty)
                  Positioned(
                    right: querySize.height * 0.026,
                    top: querySize.width * 0.064,
                    child: Container(
                      width: 5.9,
                      height: 5.9,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            );
          }),
          // GestureDetector(
          //   onTap: () {
          //     // Add action for cart button tap here
          //   },
          //   child: Container(
          //     width: querySize.width * 0.07,
          //     height: querySize.width * 0.07, // Use width for square dimensions
          //     child: Image.asset(
          //       'assets/images/bag-2.png',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
