// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lenore/presentation/screens/account_screen/account_screen.dart';
// import 'package:lenore/presentation/screens/bottom_nav_bar/widget/bottom_bar_widget.dart';
// import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
// import 'package:lenore/presentation/screens/cateogories_screen/categories_screen.dart';
// import 'package:lenore/presentation/screens/customise/customise.dart';
// import 'package:lenore/presentation/screens/favourite_screen/favourite_screen.dart';
// import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';

// import 'package:lenore/presentation/screens/home/home_screen.dart';
// import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';
// import 'package:lenore/presentation/widgets/top_bar_title.dart';

// class BottomNaveBar extends StatefulWidget {
//   //final StatefulNavigationShell navigationShell;

//   const BottomNaveBar({/*required this.navigationShell,*/ super.key});

//   @override
//   State<BottomNaveBar> createState() => _BottomNaveBarState();
// }

// class _BottomNaveBarState extends State<BottomNaveBar> {
//   int _currentIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     final List<Widget> _screens = [
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
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: Container(
//         height: querySize.height * 0.08,
//         decoration: const BoxDecoration(
//           // borderRadius: BorderRadius.only(
//           //   topLeft: Radius.circular(
//           //       querySize.width * 0.1), // Set radius for the top-left corner
//           //   topRight: Radius.circular(
//           //       querySize.width * 0.1), // Set radius for the top-right corner
//           // ),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               spreadRadius: 2,
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () => _onItemTapped(0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _currentIndex == 0
//                       ? symbol(
//                           name: "Home",
//                           logo: "assets/images/bottom_nav1/home.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFF00ACB3),
//                           textColor: const Color(0xFF00ACB3))
//                       : symbol(
//                           name: "Home",
//                           logo: "assets/images/bottom_nav1/home.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFFAAAEAE),
//                           textColor: const Color(0xFF727272)),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _onItemTapped(1),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _currentIndex == 1
//                       ? symbol(
//                           name: "Category",
//                           logo: "assets/images/bottom_nav1/category.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFF00ACB3),
//                           textColor: const Color(0xFF00ACB3))
//                       : symbol(
//                           name: "Category",
//                           logo: "assets/images/bottom_nav1/category.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFFAAAEAE),
//                           textColor: const Color(0xFF727272)),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _onItemTapped(2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _currentIndex == 2
//                       ? symbol(
//                           name: "Customise",
//                           logo: "assets/images/bottom_nav1/customise.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFF00ACB3),
//                           textColor: const Color(0xFF00ACB3))
//                       : symbol(
//                           name: "Customise",
//                           logo: "assets/images/bottom_nav1/customise.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFFAAAEAE),
//                           textColor: const Color(0xFF727272)),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _onItemTapped(3),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _currentIndex == 3
//                       ? symbol(
//                           name: "Repair",
//                           logo: "assets/images/bottom_nav1/repair.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFF00ACB3),
//                           textColor: const Color(0xFF00ACB3))
//                       : symbol(
//                           name: "Repair",
//                           logo: "assets/images/bottom_nav1/repair.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFFAAAEAE),
//                           textColor: const Color(0xFF727272)),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _onItemTapped(4),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _currentIndex == 4
//                       ? symbol(
//                           name: "Account",
//                           logo: "assets/images/bottom_nav1/account.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFF00ACB3),
//                           textColor: const Color(0xFF00ACB3))
//                       : symbol(
//                           name: "Account",
//                           logo: "assets/images/bottom_nav1/account.svg",
//                           querySize: querySize,
//                           colorCode: const Color(0xFFAAAEAE),
//                           textColor: const Color(0xFF727272)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ////////--------------------////////////////////
// // import 'package:flutter/material.dart';
// // import 'package:lenore/presentation/screens/bottom_nav_bar/widget/bottom_bar_widget.dart';
// // import 'package:lenore/presentation/screens/cart_screen/cart_screen.dart';
// // import 'package:lenore/presentation/screens/cateogories_screen/categories_screen.dart';
// // import 'package:lenore/presentation/screens/favourite_screen/favourite_screen.dart';
// // import 'package:lenore/presentation/screens/filter_screen/filter_Screen.dart';
// // import 'package:lenore/presentation/screens/home/home_screen.dart';

// // class BottomNaveBar extends StatefulWidget {
// //   const BottomNaveBar({super.key});

// //   @override
// //   State<BottomNaveBar> createState() => _BottomNaveBarState();
// // }

// // class _BottomNaveBarState extends State<BottomNaveBar> {
// //   int _currentIndex = 0;

// //   final List<Widget> _screens = [
// //     const HomeScreen(),
// //     const CategoriesScreen(),
// //     const FilterScreen(),
// //     const FavouriteScreen(),
// //     const CartScreen(),
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var querySize = MediaQuery.of(context).size;
// //     return Scaffold(
// //       body: _screens[_currentIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         type: BottomNavigationBarType.fixed,
// //         currentIndex: _currentIndex,
// //         onTap: _onItemTapped,
// //         items: [
// //           BottomNavigationBarItem(
// //               icon: _currentIndex == 0
// //                   ? symbol(
// //                       "home", "assets/images/bottom_nav1/home.png", querySize)
// //                   : Image.asset("assets/images/bottom_nav1/home.png",
// //                       height: 24),
// //               label: ""),
// //           BottomNavigationBarItem(
// //             icon: _currentIndex == 1
// //                 ? symbol("Category", "assets/images/bottom_nav1/category.png",
// //                     querySize)
// //                 : Image.asset("assets/images/bottom_nav1/category.png",
// //                     height: 24),
// //             label: '',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: _currentIndex == 2
// //                 ? Image.asset(
// //                     "assets/images/bottom_nav1/filter1.png",
// //                     height: 57,
// //                   )
// //                 : Image.asset(
// //                     "assets/images/bottom_nav1/filter.png",
// //                     height: 25,
// //                     color: const Color.fromARGB(255, 93, 101, 102),
// //                   ),
// //             label: "",
// //           ),
// //           BottomNavigationBarItem(
// //             icon: _currentIndex == 3
// //                 ? symbol("Favourites", "assets/images/bottom_nav1/fav.png",
// //                     querySize)
// //                 : Image.asset("assets/images/bottom_nav1/fav.png", height: 24),
// //             label: "",
// //           ),
// //           BottomNavigationBarItem(
// //             icon: _currentIndex == 4
// //                 ? symbol("Profile", "assets/images/bottom_nav1/profile.png",
// //                     querySize)
// //                 : Image.asset("assets/images/bottom_nav1/profile.png",
// //                     height: 24),
// //             label: "",
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';

// // class CustomBottomNavBar extends StatefulWidget {
// //   @override
// //   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// // }

// // class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
// //   int _selectedIndex = 0;

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomAppBar(
// //       shape: CircularNotchedRectangle(),
// //       notchMargin: 8.0,
// //       child: Container(
// //         height: 60,
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: <Widget>[
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 MaterialButton(
// //                   minWidth: 40,
// //                   onPressed: () {
// //                     _onItemTapped(0);
// //                   },
// //                   child: Icon(
// //                     Icons.home,
// //                     color: _selectedIndex == 0 ? Colors.black : Colors.grey,
// //                   ),
// //                 ),
// //                 MaterialButton(
// //                   minWidth: 40,
// //                   onPressed: () {
// //                     _onItemTapped(1);
// //                   },
// //                   child: Icon(
// //                     Icons.grid_view,
// //                     color: _selectedIndex == 1 ? Colors.black : Colors.grey,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 MaterialButton(
// //                   minWidth: 40,
// //                   onPressed: () {
// //                     _onItemTapped(2);
// //                   },
// //                   child: Icon(
// //                     Icons.favorite_border,
// //                     color: _selectedIndex == 2 ? Colors.black : Colors.grey,
// //                   ),
// //                 ),
// //                 MaterialButton(
// //                   minWidth: 40,
// //                   onPressed: () {
// //                     _onItemTapped(3);
// //                   },
// //                   child: Icon(
// //                     Icons.person_outline,
// //                     color: _selectedIndex == 3 ? Colors.black : Colors.grey,
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class CustomBottomAppBar extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       alignment: FractionalOffset.center,
// //       children: [
// //         BottomAppBar(
// //           shape: CircularNotchedRectangle(),
// //           notchMargin: 8.0,
// //           child: Container(
// //             height: 60.0,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: <Widget>[
// //                 SizedBox(width: 20),
// //                 IconButton(
// //                   icon: Icon(Icons.home),
// //                   onPressed: () {},
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.grid_view),
// //                   onPressed: () {},
// //                 ),
// //                 SizedBox(width: 20), // The dummy child
// //                 IconButton(
// //                   icon: Icon(Icons.favorite_border),
// //                   onPressed: () {},
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.person_outline),
// //                   onPressed: () {},
// //                 ),
// //                 SizedBox(width: 20),
// //               ],
// //             ),
// //           ),
// //         ),
// //         FloatingActionButton(
// //           onPressed: () {},
// //           tooltip: 'Filter',
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.tune),
// //               Text(
// //                 'Filter',
// //                 style: TextStyle(fontSize: 10),
// //               ),
// //             ],
// //           ),
// //           backgroundColor: Color(0xFF00ACB3), // Adjust color as needed
// //         ),
// //       ],
// //     );
// //   }
// // }
