// // import 'package:employer_app/src/features/add_job/view/add_job_page.dart';
// // import 'package:employer_app/src/features/bottom_navigation/view/bottom_navigation_page.dart';
// // import 'package:employer_app/src/features/home/view/home_page.dart';
// // import 'package:employer_app/src/features/inbox/view/inbox_detail_page.dart';
// // import 'package:employer_app/src/features/inbox/view/inbox_page.dart';
// // import 'package:employer_app/src/features/login/view/login_page.dart';
// // import 'package:employer_app/src/features/my_jobs/models/job.dart';
// // import 'package:employer_app/src/features/my_jobs/view/add_job_success.dart';
// // import 'package:employer_app/src/features/my_jobs/view/job_detail_page.dart';
// // import 'package:employer_app/src/features/my_jobs/view/job_profile_details.dart';
// // import 'package:employer_app/src/features/my_jobs/view/my_job_detail_screen.dart';
// // import 'package:employer_app/src/features/my_jobs/view/my_jobs_page.dart';
// // import 'package:employer_app/src/features/notify/view/notify_page.dart';
// // import 'package:employer_app/src/features/onboard/view/onboard_page.dart';
// // import 'package:employer_app/src/features/otp/view/otp_page.dart';
// // import 'package:employer_app/src/features/profile/view/profile_creation_page.dart';
// // import 'package:employer_app/src/features/profile/view/profile_info_page.dart';
// // import 'package:employer_app/src/features/profile/view/profile_page.dart';
// // import 'package:employer_app/src/features/settings/view/account_settings_page.dart';
// // import 'package:employer_app/src/features/settings/view/notification_page.dart';
// // import 'package:employer_app/src/features/splash/view/splash_page.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lenore/presentation/screens/account_screen/account_screen.dart';
// import 'package:lenore/presentation/screens/bottom_nav_bar/custom_bottom_nav_bar.dart';
// import 'package:lenore/presentation/screens/customise/customise.dart';
// import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
// import 'package:lenore/presentation/screens/gift_by_event_screen/gift_by_event_screen.dart';
// import 'package:lenore/presentation/screens/gift_by_voucher_screen/gift_by_voucher_screen.dart';
// import 'package:lenore/presentation/screens/home/home_screen.dart';
// import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
// import 'package:lenore/presentation/screens/login_screen/otp_screen/otp_screen.dart';
// import 'package:lenore/presentation/screens/login_screen/personal_details_screen/personal_details_screen.dart';
// import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
// import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';
// import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';
// import 'package:lenore/presentation/screens/splash/splash_screen.dart';
// import 'package:lenore/presentation/screens/sub_category_screen/sub_category_screen.dart';

// final globalNavigatorKey = GlobalKey<NavigatorState>();

// class NamedRoutes {
//   const NamedRoutes();

//   String get splash => 'splash';
//   String get wishList => 'wishList';
//   String get subCategory => 'subCategory';
//   String get profile => 'profile';
//   String get repair => 'repair';
//   String get profileEdit => 'profileEdit';
//   String get productListing => 'productListing';
//   String get productDetail => 'productDetail';
//   String get payment => 'payment';
//   String get mobileNumber => 'mobileNumber';
//   String get otp => 'otp';
//   String get personalDetail => 'personalDetail';
//   String get home => 'home';
//   String get orderHistory => 'orderHistory';
//   String get orderDetail => 'orderDetail';
//   String get notification => 'notification';
//   String get giftByVoucher => 'giftyVoucher';
//   String get giftByEvent => 'giftByEvent';
//   String get filter => 'filter';
//   String get giftByCategory => 'giftByScategory';
//   String get favourite => 'favourite';
//   String get customise => 'customise';
//   String get collection => 'collection';
//   String get checkOutScreen => 'checkOutScreen';
//   String get category => 'category';
//   String get categorySeeMore => 'categorySeeMoree';
//   String get cart => 'cart';
//   String get account => 'account';
// }

// extension PathX on String {
//   String get path {
//     return '/$this';
//   }
// }

// class Routes {
//   static final Routes _instance = Routes._internal();

//   static Routes get instance => _instance;

//   static late final GoRouter router;

//   static NamedRoutes named = const NamedRoutes();
//   Routes._internal();

//   static void initializeRouter() {
//     router = GoRouter(
//       initialLocation: Routes.named.splash.path,
//       navigatorKey: globalNavigatorKey,
//       routes: [
//         GoRoute(
//           path: Routes.named.splash.path,
//           name: Routes.named.splash,
//           builder: (context, state) => const SplashScreen(),
//         ),
//         GoRoute(
//           path: Routes.named.mobileNumber.path,
//           name: Routes.named.mobileNumber,
//           builder: (context, state) => const MobileNumberInputScreen(),
//           routes: [
//             GoRoute(
//               path: Routes.named.otp,
//               name: Routes.named.otp,
//               builder: (context, state) => const OtpScreen(),
//             )
//           ],
//         ),
//         GoRoute(
//           path: Routes.named.personalDetail.path,
//           name: Routes.named.personalDetail,
//           builder: (context, state) => const PersonalDetailsScreen(),
//           routes: const [],
//         ),
//         // GoRoute(
//         //   path: Routes.named.login.path,
//         //   name: Routes.named.login,
//         //   builder: (context, state) => const LoginPage(),
//         // ),
//         // GoRoute(
//         //     path: Routes.named.addJob.path,
//         //     name: Routes.named.addJob,
//         //     builder: (context, state) => const AddJobPage(),
//         //     routes: const []),
//         // GoRoute(
//         //   path: Routes.named.jobDetailPage.path,
//         //   name: Routes.named.jobDetailPage,
//         //   builder: (context, state) => JobDetailPage(
//         //     job: Job(
//         //         address: 'Notinham, UK',
//         //         hospital: 'Alexia',
//         //         rate: '€30K-€40K/An',
//         //         title: 'Junior Nurse'),
//         //   ),
//         // ),
//         // GoRoute(
//         //     path: Routes.named.addJobSuccess.path,
//         //     name: Routes.named.addJobSuccess,
//         //     builder: (context, state) => const AddJobSuccess(),
//         //     routes: const []),
//         StatefulShellRoute.indexedStack(
//           builder: (BuildContext context, GoRouterState state,
//               StatefulNavigationShell navigationShell) {
//             return BottomNaveBar(
//               navigationShell: navigationShell,
//             );
//           },
//           branches: <StatefulShellBranch>[
//             StatefulShellBranch(
//               routes: <RouteBase>[
//                 GoRoute(
//                   path: Routes.named.home.path,
//                   name: Routes.named.home,
//                   builder: (BuildContext context, GoRouterState state) {
//                     return const HomeScreen();
//                   },
//                   routes: <RouteBase>[
//                     GoRoute(
//                         path: Routes.named.giftByEvent,
//                         name: Routes.named.giftByEvent,
//                         builder: (context, state) => const GiftByEventScreen(),
//                         routes: [
//                           GoRoute(
//                             path: Routes.named.productListing,
//                             name: Routes.named.productListing,
//                             parentNavigatorKey: globalNavigatorKey,
//                             builder: (context, state) =>
//                                 const ProductListingScreen(
//                               productListingScreenName: '',
//                             ),
//                           ),
//                           GoRoute(
//                             path: Routes.named.productDetail,
//                             name: Routes.named.productDetail,
//                             parentNavigatorKey: globalNavigatorKey,
//                             builder: (context, state) =>
//                                 const ProductDetailScreen(),
//                           ),
//                         ]),
//                     GoRoute(
//                         path: Routes.named.giftByCategory,
//                         name: Routes.named.giftByCategory,
//                         parentNavigatorKey: globalNavigatorKey,
//                         builder: (context, state) =>
//                             const GiftByCategoryScreen(),
//                         routes: [
//                           GoRoute(
//                               path: Routes.named.subCategory,
//                               name: Routes.named.subCategory,
//                               parentNavigatorKey: globalNavigatorKey,
//                               builder: (context, state) =>
//                                   const SubCategoryScreen(
//                                     screenName: '',
//                                   ),
//                               routes: [
//                                 // GoRoute(
//                                 //   path: Routes.named.productListing,
//                                 //   name: Routes.named.productListing,
//                                 //   parentNavigatorKey: globalNavigatorKey,
//                                 //   builder: (context, state) =>
//                                 //       ProductListingScreen(
//                                 //     productListingScreenName: '',
//                                 //   ),
//                                 // ),
//                                 // GoRoute(
//                                 //   path: Routes.named.productDetail,
//                                 //   name: Routes.named.productDetail,
//                                 //   parentNavigatorKey: globalNavigatorKey,
//                                 //   builder: (context, state) =>
//                                 //       const ProductDetailScreen(),
//                                 // ),
//                               ]),
//                         ]),
//                     GoRoute(
//                       path: Routes.named.giftByVoucher,
//                       name: Routes.named.giftByVoucher,
//                       parentNavigatorKey: globalNavigatorKey,
//                       builder: (context, state) => const GiftByVoucherScreen(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             StatefulShellBranch(
//               routes: <RouteBase>[
//                 GoRoute(
//                   path: Routes.named.category.path,
//                   name: Routes.named.category,
//                   builder: (BuildContext context, GoRouterState state) {
//                     return const GiftByCategoryScreen();
//                   },
//                   routes: <RouteBase>[
//                     // GoRoute(
//                     // path: 'myJobDetailPage',
//                     // name: Routes.named.myJobDetailPage,
//                     // parentNavigatorKey: globalNavigatorKey,
//                     // builder: (BuildContext context, GoRouterState state) {
//                     //   return const MyJobDetailScreen();
//                     // },
//                     // routes: <RouteBase>[
//                     //   GoRoute(
//                     //     path: 'jobProfileDetailPage',
//                     //     name: Routes.named.jobProfileDetailPage,
//                     //     parentNavigatorKey: globalNavigatorKey,
//                     //     builder:
//                     //         (BuildContext context, GoRouterState state) {
//                     //       return const JobProfileDetailPage();
//                     //     },
//                     //   ),
//                     // ]),
//                   ],
//                 ),
//               ],
//             ),
//             StatefulShellBranch(
//               routes: <RouteBase>[
//                 GoRoute(
//                   path: Routes.named.customise.path,
//                   name: Routes.named.customise,
//                   builder: (BuildContext context, GoRouterState state) {
//                     return const CustomisationScreen();
//                   },
//                   routes: <RouteBase>[
//                     // GoRoute(
//                     //   path: 'details',
//                     //   builder: (BuildContext context, GoRouterState state) {
//                     //     return const DetailsScreen(label: 'A');
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//             StatefulShellBranch(
//               routes: <RouteBase>[
//                 GoRoute(
//                   path: Routes.named.repair.path,
//                   name: Routes.named.repair,
//                   builder: (BuildContext context, GoRouterState state) {
//                     return const RepairScreen();
//                   },
//                   routes: <RouteBase>[
//                     // GoRoute(
//                     //   path: 'inboxDetail',
//                     //   name: Routes.named.inboxDetail,
//                     //   parentNavigatorKey: globalNavigatorKey,
//                     //   builder: (BuildContext context, GoRouterState state) {
//                     //     return const InboxDetailPage();
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//             StatefulShellBranch(
//               routes: <RouteBase>[
//                 GoRoute(
//                   path: Routes.named.account.path,
//                   name: Routes.named.account,
//                   builder: (BuildContext context, GoRouterState state) {
//                     return const AccountScreen();
//                   },
//                   routes: <RouteBase>[
//                     // GoRoute(
//                     //   path: 'inboxDetail',
//                     //   name: Routes.named.inboxDetail,
//                     //   parentNavigatorKey: globalNavigatorKey,
//                     //   builder: (BuildContext context, GoRouterState state) {
//                     //     return const InboxDetailPage();
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//       errorPageBuilder: (context, state) {
//         return MaterialPage<void>(
//           key: state.pageKey,
//           child: Scaffold(
//             body: Center(
//               child: Text(state.error.toString()),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // // // import 'package:employer_app/src/features/add_job/view/add_job_page.dart';
// // // // import 'package:employer_app/src/features/bottom_navigation/view/bottom_navigation_page.dart';
// // // // import 'package:employer_app/src/features/home/view/home_page.dart';
// // // // import 'package:employer_app/src/features/inbox/view/inbox_detail_page.dart';
// // // // import 'package:employer_app/src/features/inbox/view/inbox_page.dart';
// // // // import 'package:employer_app/src/features/login/view/login_page.dart';
// // // // import 'package:employer_app/src/features/my_jobs/models/job.dart';
// // // // import 'package:employer_app/src/features/my_jobs/view/add_job_success.dart';
// // // // import 'package:employer_app/src/features/my_jobs/view/job_detail_page.dart';
// // // // import 'package:employer_app/src/features/my_jobs/view/job_profile_details.dart';
// // // // import 'package:employer_app/src/features/my_jobs/view/my_job_detail_screen.dart';
// // // // import 'package:employer_app/src/features/my_jobs/view/my_jobs_page.dart';
// // // // import 'package:employer_app/src/features/notify/view/notify_page.dart';
// // // // import 'package:employer_app/src/features/onboard/view/onboard_page.dart';
// // // // import 'package:employer_app/src/features/otp/view/otp_page.dart';
// // // // import 'package:employer_app/src/features/profile/view/profile_creation_page.dart';
// // // // import 'package:employer_app/src/features/profile/view/profile_info_page.dart';
// // // // import 'package:employer_app/src/features/profile/view/profile_page.dart';
// // // // import 'package:employer_app/src/features/settings/view/account_settings_page.dart';
// // // // import 'package:employer_app/src/features/settings/view/notification_page.dart';
// // // // import 'package:employer_app/src/features/splash/view/splash_page.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:go_router/go_router.dart';
// // // import 'package:lenore/presentation/screens/account_screen/account_screen.dart';
// // // import 'package:lenore/presentation/screens/bottom_nav_bar/custom_bottom_nav_bar.dart';
// // // import 'package:lenore/presentation/screens/customise/customise.dart';
// // // import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
// // // import 'package:lenore/presentation/screens/home/home_screen.dart';
// // // import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';

// // // final globalNavigatorKey = GlobalKey<NavigatorState>();

// // // class NamedRoutes {
// // //   const NamedRoutes();

// // //   String get splash => 'splash';
// // //   String get onboard => 'onboard';
// // //   String get profile => 'profile';
// // //   String get profileCreation => 'profileCreation';
// // //   String get aboutAddingPage => 'aboutAddingPage';
// // //   String get serviceAddingPage => 'serviceAddingPage';
// // //   String get paymentSelectionPage => 'paymentSelectionPage';
// // //   String get slotSelectionPage => 'slotSelectionPage';
// // //   String get updateYourSlot => 'updateYourSlot';
// // //   String get otp => 'otp';
// // //   String get login => 'login';
// // //   String get home => 'home';
// // //   String get myjobs => 'myjobs';
// // //   String get scheduledDetailPage => 'scheduledDetailPage';
// // //   String get notify => 'notify';
// // //   String get accountSetting => 'accountSetting';
// // //   String get jobDetailResumeDocumentUpload => 'jobDetailResumeDocumentUpload';
// // //   String get personalInfo => 'personalInfo';
// // //   String get plansPage => 'plansPage';
// // //   String get notifications => 'notifications';
// // //   String get addJob => 'addJob';
// // //   String get jobDetailPage => 'jobDetailPage';
// // //   String get myJobDetailPage => 'myJobDetailPage';
// // //   String get jobProfileDetailPage => 'jobProfileDetailPage';
// // //   String get addJobSuccess => 'addJobSuccess';
// // //   String get inboxDetail => 'inboxDetail';
// // //   String get inbox => 'inbox';
// // // }

// // // extension PathX on String {
// // //   String get path {
// // //     return '/$this';
// // //   }
// // // }

// // // class Routes {
// // //   static final Routes _instance = Routes._internal();

// // //   static Routes get instance => _instance;

// // //   static late final GoRouter router;

// // //   static NamedRoutes named = const NamedRoutes();

// // //   Routes._internal() {
// // //     router = GoRouter(
// // //       initialLocation: Routes.named.splash.path,
// // //       navigatorKey: globalNavigatorKey,
// // //       routes: [
// // //         GoRoute(
// // //           path: Routes.named.splash.path,
// // //           name: Routes.named.splash,
// // //           builder: (context, state) => const HomeScreen(),
// // //         ),
// // //         GoRoute(
// // //           path: Routes.named.onboard.path,
// // //           name: Routes.named.onboard,
// // //           builder: (context, state) => const GiftByCategoryScreen(),
// // //           routes: [
// // //             GoRoute(
// // //                 path: Routes.named.otp,
// // //                 name: Routes.named.otp,
// // //                 builder: (context, state) => CustomisationScreen())
// // //           ],
// // //         ),
// // //         GoRoute(
// // //           path: Routes.named.profileCreation.path,
// // //           name: Routes.named.profileCreation,
// // //           builder: (context, state) => const RepairScreen(),
// // //           routes: const [],
// // //         ),
// // //         GoRoute(
// // //           path: Routes.named.login.path,
// // //           name: Routes.named.login,
// // //           builder: (context, state) => const AccountScreen(),
// // //         ),
// // //         // GoRoute(
// // //         //     path: Routes.named.addJob.path,
// // //         //     name: Routes.named.addJob,
// // //         //     builder: (context, state) => const AddJobPage(),
// // //         //     routes: const []),
// // //         // GoRoute(
// // //         //   path: Routes.named.jobDetailPage.path,
// // //         //   name: Routes.named.jobDetailPage,
// // //         //   builder: (context, state) => JobDetailPage(
// // //         //     job: Job(
// // //         //         address: 'Notinham, UK',
// // //         //         hospital: 'Alexia',
// // //         //         rate: '€30K-€40K/An',
// // //         //         title: 'Junior Nurse'),
// // //         //   ),
// // //         // ),
// // //         // GoRoute(
// // //         //     path: Routes.named.addJobSuccess.path,
// // //         //     name: Routes.named.addJobSuccess,
// // //         //     builder: (context, state) => const AddJobSuccess(),
// // //         //     routes: const []),
// // //         StatefulShellRoute.indexedStack(
// // //           builder: (BuildContext context, GoRouterState state,
// // //               StatefulNavigationShell navigationShell) {
// // //             return BottomNaveBar(
// // //                 //  navigationShell: navigationShell,
// // //                 );
// // //           },
// // //           branches: <StatefulShellBranch>[
// // //             StatefulShellBranch(
// // //               routes: <RouteBase>[
// // //                 GoRoute(
// // //                   path: Routes.named.home.path,
// // //                   name: Routes.named.home,
// // //                   builder: (BuildContext context, GoRouterState state) {
// // //                     return const HomePage();
// // //                   },
// // //                   routes: <RouteBase>[
// // //                     GoRoute(
// // //                         path: Routes.named.profile,
// // //                         name: Routes.named.profile,
// // //                         builder: (context, state) => const ProfilePage(),
// // //                         routes: [
// // //                           GoRoute(
// // //                             path: Routes.named.personalInfo,
// // //                             name: Routes.named.personalInfo,
// // //                             parentNavigatorKey: globalNavigatorKey,
// // //                             builder: (context, state) =>
// // //                                 const ProfileInfoPage(),
// // //                           ),
// // //                           GoRoute(
// // //                             path: Routes.named.notifications,
// // //                             name: Routes.named.notifications,
// // //                             parentNavigatorKey: globalNavigatorKey,
// // //                             builder: (context, state) =>
// // //                                 const NotificationPage(),
// // //                           ),
// // //                           GoRoute(
// // //                             path: Routes.named.accountSetting,
// // //                             name: Routes.named.accountSetting,
// // //                             parentNavigatorKey: globalNavigatorKey,
// // //                             builder: (context, state) =>
// // //                                 const AccountSittingsPage(),
// // //                           ),
// // //                         ]),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             StatefulShellBranch(
// // //               routes: <RouteBase>[
// // //                 GoRoute(
// // //                   path: Routes.named.myjobs.path,
// // //                   name: Routes.named.myjobs,
// // //                   builder: (BuildContext context, GoRouterState state) {
// // //                     return const MyJobsPage();
// // //                   },
// // //                   routes: <RouteBase>[
// // //                     GoRoute(
// // //                         path: 'myJobDetailPage',
// // //                         name: Routes.named.myJobDetailPage,
// // //                         parentNavigatorKey: globalNavigatorKey,
// // //                         builder: (BuildContext context, GoRouterState state) {
// // //                           return const MyJobDetailScreen();
// // //                         },
// // //                         routes: <RouteBase>[
// // //                           GoRoute(
// // //                             path: 'jobProfileDetailPage',
// // //                             name: Routes.named.jobProfileDetailPage,
// // //                             parentNavigatorKey: globalNavigatorKey,
// // //                             builder:
// // //                                 (BuildContext context, GoRouterState state) {
// // //                               return const JobProfileDetailPage();
// // //                             },
// // //                           ),
// // //                         ]),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             StatefulShellBranch(
// // //               routes: <RouteBase>[
// // //                 GoRoute(
// // //                   path: Routes.named.notify.path,
// // //                   name: Routes.named.notify,
// // //                   builder: (BuildContext context, GoRouterState state) {
// // //                     return const NotifyPage();
// // //                   },
// // //                   routes: <RouteBase>[
// // //                     GoRoute(
// // //                       path: 'details',
// // //                       builder: (BuildContext context, GoRouterState state) {
// // //                         return const DetailsScreen(label: 'A');
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             StatefulShellBranch(
// // //               routes: <RouteBase>[
// // //                 GoRoute(
// // //                   path: Routes.named.inbox.path,
// // //                   name: Routes.named.inbox,
// // //                   builder: (BuildContext context, GoRouterState state) {
// // //                     return const InboxPage();
// // //                   },
// // //                   routes: <RouteBase>[
// // //                     GoRoute(
// // //                       path: 'inboxDetail',
// // //                       name: Routes.named.inboxDetail,
// // //                       parentNavigatorKey: globalNavigatorKey,
// // //                       builder: (BuildContext context, GoRouterState state) {
// // //                         return const InboxDetailPage();
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ],
// // //       errorPageBuilder: (context, state) {
// // //         return MaterialPage<void>(
// // //           key: state.pageKey,
// // //           child: Scaffold(
// // //             body: Center(
// // //               child: Text(state.error.toString()),
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
