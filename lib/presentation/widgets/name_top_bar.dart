import 'package:flutter/material.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';

import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';

import 'package:provider/provider.dart';

Row nameTopBar(Size querySize, BuildContext context, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/back_blue_icon.png',
          height: querySize.height * 0.035,
        ),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: querySize.width * (30 / 375),
                color: const Color(0xFF008186),
                fontFamily: 'ElMessirisemibold'),
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
    ],
  );
}
