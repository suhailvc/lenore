import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

Row homeSectionTitle(Size querySize, String sectionTitle, BuildContext context,
    navigationScreenName) {
  return Row(
    children: [
      Text(
        sectionTitle,
        style: TextStyle(
            color: const Color(0xFF008186),
            fontSize: querySize.width * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: 'ElMessiri'),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () {
          // onGenerateRoute:
          // (_) => MaterialPageRoute(builder: (context) => navigationScreenName);
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: navigationScreenName,
          //   withNavBar: true,
          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          // );
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navigationScreenName,
              ));
        },
        child: Text(
          "View More",
          style: TextStyle(
              color: const Color(0xFF00ACB3),
              fontSize: querySize.width * 0.033,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFF00ACB3),
              fontFamily: 'Segoe'),
        ),
      ),
    ],
  );
}
