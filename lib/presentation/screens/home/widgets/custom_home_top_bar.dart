import 'package:flutter/material.dart';
import 'package:lenore/application/provider/search_provider/search_provider.dart';
import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
import 'package:lenore/presentation/screens/search_screen/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

Row customHomeTopBar(Size querySize, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        'assets/images/splash_screen.png',
        height: querySize.height * 0.05,
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: SearchScreen(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
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
                Icon(
                  Icons.search,
                  color: const Color(0xFF00ACB3),
                  size: querySize.height * 0.034,
                ),
                SizedBox(width: querySize.width * 0.03),
                Expanded(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: Color(0xFF7A7A7A),
                          fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
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
      // Expanded(
      //   child: Container(
      //     margin: EdgeInsets.symmetric(horizontal: querySize.height * 0.01),
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //     height: querySize.height * 0.058,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(30.0),
      //       border: Border.all(
      //         color: const Color(0x38F3FFFF),
      //         width: 1.1,
      //       ),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.5),
      //           spreadRadius: 1,
      //           blurRadius: 1,
      //         ),
      //       ],
      //     ),
      //     child: Row(
      //       children: [
      //         Icon(
      //           Icons.search,
      //           color: const Color(0xFF00ACB3),
      //           size: querySize.height * 0.034,
      //         ),
      //         const SizedBox(width: 10.0),
      //         const Expanded(
      //           child: TextField(
      //             decoration: InputDecoration(
      //               hintText: 'Search',
      //               hintStyle: TextStyle(
      //                   color: Color(0xFF7A7A7A), fontWeight: FontWeight.w600),
      //               border: InputBorder.none,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // IconButton(
      //   icon: Image.asset(
      //     'assets/images/home/Group 28.png',
      //     height: querySize.height * 0.033,
      //   ),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const CartScreen(),
      //         ));
      //   },
      // ),
    ],
  );
}
