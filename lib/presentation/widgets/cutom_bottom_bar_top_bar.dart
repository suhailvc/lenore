import 'package:flutter/material.dart';
import 'package:lenore/presentation/screens/bottom_nav_bar/custom_bottom_nav_bar.dart';

import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
import 'package:lenore/presentation/screens/home/home_screen.dart';

Row customBottomBarTopBar(Size querySize, BuildContext context) {
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: querySize.height * 0.01),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          height: querySize.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(querySize.width * 0.1),
            border: Border.all(
              color: const Color(0x38F3FFFF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: Icon(
                  Icons.search,
                  color: const Color(0xFF00ACB3),
                  size: querySize.height * 0.034,
                ),
              ),
              SizedBox(width: querySize.width * 0.03),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Color(0xFF7A7A7A), fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
    ],
  );
}
