import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/account_screen/account_screen.dart';
import 'package:lenore/presentation/screens/customise/customise.dart';
import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
import 'package:lenore/presentation/screens/home/home_screen.dart';
import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';
import 'package:lenore/presentation/widgets/custom_category_top_bar.dart';

import 'package:lenore/presentation/widgets/top_bar_title.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersistantBottomNavBarScreen extends StatefulWidget {
  const PersistantBottomNavBarScreen({super.key});

  @override
  State<PersistantBottomNavBarScreen> createState() =>
      _PersistantBottomNavBarScreenState();
}

class _PersistantBottomNavBarScreenState
    extends State<PersistantBottomNavBarScreen> {
  final _controller = PersistentTabController(initialIndex: 0);

  // Create a list of GlobalKeys for each tab's Navigator
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (index) => GlobalKey<NavigatorState>(),
  );

  // Handle system back button
  Future<bool> _onWillPop() async {
    final currentNavigatorState =
        _navigatorKeys[_controller.index].currentState;
    if (currentNavigatorState?.canPop() ?? false) {
      currentNavigatorState?.pop();
      return false; // Don't exit app
    }
    return true; // Allow exiting app
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    final List<Widget> screens = [
      Navigator(
        key: _navigatorKeys[0],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
      Navigator(
        key: _navigatorKeys[1],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => GiftByCategoryScreen(
            widget: customCAtegoryTopBar(querySize, context),
          ),
        ),
      ),
      Navigator(
        key: _navigatorKeys[2],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => CustomisationScreen(
            widgetName: topBarTitle(querySize, context, 'Customize'),
          ),
        ),
      ),
      Navigator(
        key: _navigatorKeys[3],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => RepairScreen(
            widgetName: topBarTitle(querySize, context, 'Repair'),
          ),
        ),
      ),
      Navigator(
        key: _navigatorKeys[4],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => const AccountScreen(),
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: PersistentTabView(
        context,
        navBarHeight: querySize.height * 0.088,
        padding: EdgeInsets.symmetric(vertical: querySize.height * 0.01),
        confineToSafeArea: true,
        controller: _controller,
        screens: screens,
        items: _buildNavBarItems(querySize),
        navBarStyle: NavBarStyle.style6,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
        stateManagement: true,
        handleAndroidBackButtonPress: true,
        onItemSelected: (index) {
          if (_controller.index == index) {
            // If the same tab is selected, clear its stack
            _navigatorKeys[index]
                .currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            // If a different tab is selected, change the tab
            setState(() {
              _controller.index = index;
            });
          }
        },
      ),
    );
  }

  List<PersistentBottomNavBarItem> _buildNavBarItems(Size querySize) {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: appColor,
        icon: SvgPicture.asset(
          "assets/images/bottom_nav1/home.svg",
          width: querySize.width * 0.07,
          height: querySize.width * 0.07,
        ),
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
        inactiveColorSecondary: Colors.black,
        icon: SvgPicture.asset(
          "assets/images/bottom_nav1/category.svg",
          width: querySize.width * 0.07,
          height: querySize.width * 0.07,
        ),
        title: 'Category',
        activeColorPrimary: appColor,
        activeColorSecondary: appColor,
      ),
      PersistentBottomNavBarItem(
        inactiveColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        icon: SvgPicture.asset(
          "assets/images/bottom_nav1/customise.svg",
          width: querySize.width * 0.07,
          height: querySize.width * 0.07,
        ),
        title: 'Customise',
        activeColorPrimary: appColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/images/bottom_nav1/repair.svg",
          width: querySize.width * 0.07,
          height: querySize.width * 0.07,
        ),
        title: 'Repair',
        activeColorPrimary: appColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/images/bottom_nav1/account.svg",
          width: querySize.width * 0.07,
          height: querySize.width * 0.07,
        ),
        title: 'Account',
        activeColorPrimary: appColor,
      ),
    ];
  }
}
// class PersistantBottomNavBarScreen extends StatefulWidget {
//   const PersistantBottomNavBarScreen({super.key});

//   @override
//   State<PersistantBottomNavBarScreen> createState() =>
//       _PersistantBottomNavBarScreenState();
// }

// class _PersistantBottomNavBarScreenState
//     extends State<PersistantBottomNavBarScreen> {
//   final _controller = PersistentTabController(initialIndex: 0);

//   // Create a list of GlobalKeys for each tab's Navigator
//   final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
//     5,
//     (index) => GlobalKey<NavigatorState>(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     final List<Widget> screens = [
//       Navigator(
//         key: _navigatorKeys[0],
//         onGenerateRoute: (_) => MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       ),
//       Navigator(
//         key: _navigatorKeys[1],
//         onGenerateRoute: (_) => MaterialPageRoute(
//           builder: (context) => GiftByCategoryScreen(
//             widget: customCAtegoryTopBar(querySize, context),
//           ),
//         ),
//       ),
//       Navigator(
//         key: _navigatorKeys[2],
//         onGenerateRoute: (_) => MaterialPageRoute(
//           builder: (context) => CustomisationScreen(
//             widgetName: topBarTitle(querySize, context, 'Customize'),
//           ),
//         ),
//       ),
//       Navigator(
//         key: _navigatorKeys[3],
//         onGenerateRoute: (_) => MaterialPageRoute(
//           builder: (context) => RepairScreen(
//             widgetName: topBarTitle(querySize, context, 'Repair'),
//           ),
//         ),
//       ),
//       Navigator(
//         key: _navigatorKeys[4],
//         onGenerateRoute: (_) => MaterialPageRoute(
//           builder: (context) => const AccountScreen(),
//         ),
//       ),
//     ];

//     return PersistentTabView(
//       context,
//       navBarHeight: querySize.height * 0.088,
//       padding: EdgeInsets.symmetric(vertical: querySize.height * 0.01),
//       confineToSafeArea: true,
//       controller: _controller,
//       screens: screens,
//       items: _buildNavBarItems(querySize),
//       navBarStyle: NavBarStyle.style6,
//       popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
//       stateManagement: true,
//       onItemSelected: (index) {
//         if (_controller.index == index) {
//           // If the same tab is selected, clear its stack
//           _navigatorKeys[index]
//               .currentState
//               ?.popUntil((route) => route.isFirst);
//         } else {
//           // If a different tab is selected, change the tab
//           setState(() {
//             _controller.index = index;
//           });
//         }
//       },
//     );
//   }

//   List<PersistentBottomNavBarItem> _buildNavBarItems(Size querySize) {
//     return [
//       PersistentBottomNavBarItem(
//         // inactiveColorPrimary: Colors.black,
//         activeColorPrimary: appColor,
//         icon: SvgPicture.asset(
//           "assets/images/bottom_nav1/home.svg",
//           //  color: _controller.index == 1 ? appColor : Color(0xFFAAAEAE),
//           width: querySize.width * 0.07,
//           height: querySize.width * 0.07,
//         ),

//         title: 'Home',
//       ),
//       PersistentBottomNavBarItem(
//         inactiveColorSecondary: Colors.black,
//         // Dynamically change the icon based on the selected index
//         icon: SvgPicture.asset(
//           "assets/images/bottom_nav1/category.svg",
//           //  color: _controller.index == 1 ? appColor : Color(0xFFAAAEAE),
//           width: querySize.width * 0.07,
//           height: querySize.width * 0.07,
//         ),
//         title: 'Category',
//         activeColorPrimary: appColor,
//         activeColorSecondary: appColor,
//       ),
//       PersistentBottomNavBarItem(
//         inactiveColorSecondary: Colors.black,
//         inactiveColorPrimary: Colors.black,
//         icon: SvgPicture.asset(
//           //  color: _controller.index == 2 ? appColor : Color(0xFFAAAEAE),
//           "assets/images/bottom_nav1/customise.svg",
//           width: querySize.width * 0.07,
//           height: querySize.width * 0.07,
//         ),
//         title: 'Customise',
//         activeColorPrimary: appColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(
//           //  color: _controller.index == 3 ? appColor : Color(0xFFAAAEAE),
//           "assets/images/bottom_nav1/repair.svg",
//           width: querySize.width * 0.07,
//           height: querySize.width * 0.07,
//         ),
//         title: 'Repair',
//         activeColorPrimary: appColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(
//           // color: _controller.index == 4 ? appColor : Color(0xFFAAAEAE),
//           "assets/images/bottom_nav1/account.svg",
//           width: querySize.width * 0.07,
//           height: querySize.width * 0.07,
//         ),
//         title: 'Account',
//         activeColorPrimary: appColor,
//       ),
//     ];
//   }
// }

// class PersistantBottomNavBarScreen extends StatefulWidget {
//   const PersistantBottomNavBarScreen({super.key});

//   @override
//   State<PersistantBottomNavBarScreen> createState() =>
//       _PersistantBottomNavBarScreenState();
// }

// class _PersistantBottomNavBarScreenState
//     extends State<PersistantBottomNavBarScreen> {
//   final _controller = PersistentTabController(initialIndex: 0);
//   int _lastSelectedTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     final List<Widget> screens = [
//       const HomeScreen(),
//       GiftByCategoryScreen(
//         widget: customCAtegoryTopBar(querySize, context),
//       ),
//       CustomisationScreen(
//         widgetName: topBarTitle(querySize, context, 'Customize'),
//       ),
//       RepairScreen(
//         widgetName: topBarTitle(querySize, context, 'Repair'),
//       ),
//       const AccountScreen(),
//     ];

//     return PersistentTabView(
//       navBarHeight: querySize.height * 0.088,
//       padding: EdgeInsets.symmetric(vertical: querySize.height * 0.01),
//       confineToSafeArea: true,
//       context,
//       controller: _controller,
//       screens: screens,
//       items: _buildNavBarItems(querySize),
//       navBarStyle: NavBarStyle.style6,
//       popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
//       stateManagement: true,
//       onItemSelected: (index) {
//         // if (_lastSelectedTab == index) {
//         //   // Reset the navigation stack for the currently selected tab
//         //   PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
//         //       context);
//         // }
//         // setState(() {
//         //   _lastSelectedTab = index;
//         //   _controller.index = index;
//         // });
//         setState(() {
//           // PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
//           //     context);
//           _controller.index = index;
//         });
//       },
//     );
//   }

// List<PersistentBottomNavBarItem> _buildNavBarItems(Size querySize) {
//   return [
//     PersistentBottomNavBarItem(
//       inactiveColorPrimary: Colors.black,
//       activeColorPrimary: appColor,
//       icon: SvgPicture.asset(
//         color: _controller.index == 0 ? appColor : Color(0xFFAAAEAE),
//         "assets/images/bottom_nav1/home.svg",
//         width: querySize.width * 0.07,
//         height: querySize.width * 0.07,
//       ),
//       title: 'Home',
//     ),
//     PersistentBottomNavBarItem(
//       inactiveColorSecondary: Colors.black,
//       inactiveColorPrimary: Colors.black,
//       // Dynamically change the icon based on the selected index
//       icon:
//           // _controller.index == 1
//           //       ? Image.asset(
//           //           'assets/images/profile/email_icon.png',
//           //           width: querySize.width * 0.07,
//           //           height: querySize.width * 0.07,
//           //         )
//           //       :
//           SvgPicture.asset(
//         "assets/images/bottom_nav1/category.svg",
//         color: _controller.index == 1 ? appColor : Color(0xFFAAAEAE),
//         width: querySize.width * 0.07,
//         height: querySize.width * 0.07,
//       ),
//       title: 'Category',
//       activeColorPrimary: appColor,
//       activeColorSecondary: appColor,
//     ),
//     PersistentBottomNavBarItem(
//       inactiveColorSecondary: Colors.black,
//       inactiveColorPrimary: Colors.black,
//       icon: SvgPicture.asset(
//         color: _controller.index == 2 ? appColor : Color(0xFFAAAEAE),
//         "assets/images/bottom_nav1/customise.svg",
//         width: querySize.width * 0.07,
//         height: querySize.width * 0.07,
//       ),
//       title: 'Customise',
//       activeColorPrimary: appColor,
//     ),
//     PersistentBottomNavBarItem(
//       icon: SvgPicture.asset(
//         color: _controller.index == 3 ? appColor : Color(0xFFAAAEAE),
//         "assets/images/bottom_nav1/repair.svg",
//         width: querySize.width * 0.07,
//         height: querySize.width * 0.07,
//       ),
//       title: 'Repair',
//       activeColorPrimary: appColor,
//     ),
//     PersistentBottomNavBarItem(
//       icon: SvgPicture.asset(
//         color: _controller.index == 4 ? appColor : Color(0xFFAAAEAE),
//         "assets/images/bottom_nav1/account.svg",
//         width: querySize.width * 0.07,
//         height: querySize.width * 0.07,
//       ),
//       title: 'Account',
//       activeColorPrimary: appColor,
//     ),
//   ];
// }
// }


// import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/account_screen/account_screen.dart';
// import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
// import 'package:lenore/presentation/screens/customise/customise.dart';
// import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
// import 'package:lenore/presentation/screens/home/home_screen.dart';
// import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';
// import 'package:lenore/presentation/widgets/top_bar_title.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class PersistantBottomNavBarScreen extends StatefulWidget {
//   const PersistantBottomNavBarScreen({super.key});

//   @override
//   State<PersistantBottomNavBarScreen> createState() =>
//       _PersistantBottomNavBarScreenState();
// }

// class _PersistantBottomNavBarScreenState
//     extends State<PersistantBottomNavBarScreen> {
//   final _controller = PersistentTabController(initialIndex: 0);

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     final List<Widget> screens = [
//       const HomeScreen(),
//       const GiftByCategoryScreen(),
//       CustomisationScreen(
//         widgetName: topBarTitle(querySize, context, 'Customize'),
//       ),
//       //const FilterScreen(),
//       RepairScreen(
//         widgetName: topBarTitle(querySize, context, 'Repair'),
//       ),
//       const AccountScreen(),
//     ];
//     return PersistentTabView(
//       controller: _controller,
//       navBarStyle: NavBarStyle.style6,
//       //hideNavigationBarWhenKeyboardAppears: true,
//       context,
//       screens: screens,
//       items: [
//         PersistentBottomNavBarItem(
//           inactiveColorPrimary: Colors.black,
//           activeColorPrimary: appColor,
//           icon: SvgPicture.asset(
//             "assets/images/bottom_nav1/home.svg",
//             width: querySize.width * 0.07,
//             height: querySize.width * 0.07,
//           ),
//           title: 'Home',
//         ),
//         PersistentBottomNavBarItem(
//             inactiveColorSecondary: Colors.black,
//             inactiveColorPrimary: Colors.black,
//             icon: _controller == PersistentTabController(initialIndex: 1)
//                 ? Image.asset('assets/images/profile/email_icon.png')
//                 : '',
//             title: 'Category',
//             activeColorPrimary: appColor,
//             activeColorSecondary: appColor),
//         PersistentBottomNavBarItem(
//           inactiveColorSecondary: Colors.black,
//           inactiveColorPrimary: Colors.black,
//           icon: SvgPicture.asset(
//             "assets/images/bottom_nav1/customise.svg",
//             width: querySize.width * 0.07,
//             height: querySize.width * 0.07,
//           ),
//           title: 'Customise',
//           activeColorPrimary: appColor,
//         ),
//         PersistentBottomNavBarItem(
//           icon: SvgPicture.asset(
//             "assets/images/bottom_nav1/repair.svg",
//             width: querySize.width * 0.07,
//             height: querySize.width * 0.07,
//           ),
//           title: 'Repair',
//           activeColorPrimary: appColor,
//         ),
//         PersistentBottomNavBarItem(
//           icon: SvgPicture.asset(
//             "assets/images/bottom_nav1/account.svg",
//             width: querySize.width * 0.07,
//             height: querySize.width * 0.07,
//           ),
//           title: 'Account',
//           activeColorPrimary: appColor,
//         )
//       ],
//     );
//   }
// }
