import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/account_screen/widgets/constant.dart';
import 'package:lenore/presentation/screens/account_screen/widgets/customAccountListTile.dart';
import 'package:lenore/presentation/screens/account_screen/widgets/privacy_policy_widget.dart';
import 'package:lenore/presentation/screens/account_screen/widgets/whats_app.dart';
import 'package:lenore/presentation/screens/customise/customise.dart';
import 'package:lenore/presentation/screens/language_selection_screen/language_selection_screen.dart';
import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/presentation/screens/notification/notification_screen.dart';
import 'package:lenore/presentation/screens/order_history/order_history.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/profile_screen.dart';
import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';
import 'package:lenore/presentation/screens/wish_list_screen/wish_list_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/widgets/delete_pop_up.dart';

import 'package:lenore/presentation/widgets/logout_pop_up.dart';
import 'package:lenore/presentation/widgets/top_bar_title.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(hasBearerToken());
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(querySize),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.08),
              child: topBarTitle(querySize, context, 'Account'),
            ),
            if (!Provider.of<AuthProvider>(context).hasToken)
              Column(
                children: [
                  customSizedBox(querySize),
                  Center(
                    child: Text(
                      'Please sign in or create an account to send gift,\n  track order, and many more greate features',
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.w600,
                        fontSize: querySize.width * (10.55 / 375),
                      ),
                    ),
                  ),
                  customHeightThree(querySize),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.09),
              child: Column(
                children: [
                  if (!Provider.of<AuthProvider>(context).hasToken)
                    ElevatedButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MobileNumberInputScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          querySize.width * 0.9,
                          querySize.height * (43 / 812),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.2),
                          side: BorderSide(
                            color: const Color(0xFF00ACB3),
                            width: querySize.width * 0.004,
                          ),
                        ),
                      ),
                      child: Text(
                        'Sign In or Create Account',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  customHeightThree(querySize),
                  Container(
                    width: querySize.width * (345 / 375),
                    height: querySize.height * (135 / 812),
                    decoration: BoxDecoration(
                      color: accountContainerColor,
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.03),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: querySize.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              'assets/images/account/profile_icon.png',
                              'Profile'),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        const Divider(
                          color: Color(0xFFD3D0D0),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: querySize.width * 0.05),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const LanguageSelectionScreen(),
                        //           ));
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/account/language_icon.png',
                        //           width: querySize.width * (33 / 375),
                        //           height: querySize.height * (20 / 812),
                        //         ),
                        //         SizedBox(width: querySize.width * 0.05),
                        //         Text(
                        //           'Language',
                        //           style: TextStyle(
                        //               color: textColor,
                        //               fontWeight: FontWeight.w400,
                        //               fontFamily: 'Segoe',
                        //               fontSize: querySize.width * (16 / 375)),
                        //         ),
                        //         const Spacer(),
                        //         Text(
                        //             style: TextStyle(
                        //                 color: textColor,
                        //                 //  fontWeight: FontWeight.w400,
                        //                 fontFamily: 'Segoe',
                        //                 fontSize: querySize.width * (13 / 375)),
                        //             "English"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: querySize.height * 0.015,
                        // ),
                        // const Divider(
                        //   color: Color(0xFFD3D0D0),
                        // ),
                        // SizedBox(
                        //   height: querySize.height * 0.015,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen(),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              'assets/images/account/notification_icon.png',
                              'Notification'),
                        ),
                      ],
                    ),
                  ),
                  customSizedBox(querySize),
                  Container(
                    width: querySize.width * (345 / 375),
                    height: querySize.height * (189 / 812),
                    decoration: BoxDecoration(
                      color: accountContainerColor,
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.03),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: querySize.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WishListScreen(),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              "assets/images/account/whislist_icon.png",
                              "Wishlist"),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        const Divider(
                          color: Color(0xFFD3D0D0),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomisationScreen(
                                    widgetName: customProfileTopBar(
                                      querySize,
                                      context,
                                      "Customize",
                                    ),
                                  ),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              "assets/images/account/cutomisation_icon.png",
                              "Customization"),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        const Divider(
                          color: Color(0xFFD3D0D0),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RepairScreen(
                                    widgetName: customProfileTopBar(
                                        querySize, context, "Repair"),
                                  ),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              "assets/images/account/repair_icon.png",
                              "Repair"),
                        )
                      ],
                    ),
                  ),
                  customSizedBox(querySize),
                  Container(
                    width: querySize.width * (345 / 375),
                    height: !Provider.of<AuthProvider>(context).hasToken
                        ? querySize.height * 0.17
                        : querySize.height * (250 / 812),
                    decoration: BoxDecoration(
                      color: accountContainerColor,
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.03),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: querySize.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PrivacyPolicyScreen(),
                                ));
                            //await openWhatsApp();
                          },
                          child: customAccountListTile(
                              querySize,
                              "assets/images/account/help.png",
                              "Privacy Policy"),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        const Divider(
                          color: Color(0xFFD3D0D0),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderHistory(),
                                ));
                          },
                          child: customAccountListTile(
                              querySize,
                              "assets/images/account/order_history.png",
                              "Order History"),
                        ),
                        SizedBox(
                          height: querySize.height * 0.015,
                        ),
                        !Provider.of<AuthProvider>(context).hasToken
                            ? SizedBox()
                            : Column(
                                children: [
                                  const Divider(
                                    color: Color(0xFFD3D0D0),
                                  ),
                                  SizedBox(
                                    height: querySize.height * 0.015,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      logOutPopUp(context, querySize);
                                    },
                                    child: customAccountListTile(
                                        querySize,
                                        "assets/images/account/logout_icon.png",
                                        "Logout"),
                                  ),
                                  SizedBox(
                                    height: querySize.height * 0.015,
                                  ),
                                  const Divider(
                                    color: Color(0xFFD3D0D0),
                                  ),
                                  SizedBox(
                                    height: querySize.height * 0.015,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteAccountPopUp(context, querySize);
                                    },
                                    child: customAccountListTile(
                                        querySize,
                                        "assets/images/account/delete_icon.png",
                                        "Delete Account"),
                                  )
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
