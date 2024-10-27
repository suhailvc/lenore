import 'package:flutter/material.dart';
import 'package:lenore/application/provider/bestseller_new_aarival_product_list_provider/bestseller_new_aarival_product_list_provider.dart';
import 'package:lenore/application/provider/home_provider/best_seller_provider/best_seller_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';

import 'package:lenore/application/provider/home_provider/collection_provider/collection_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_category/gift_by_category_provider.dart';

import 'package:lenore/application/provider/home_provider/gift_by_event_provider/gift_by_event_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_voucher_provider/gift_by_voucher_provider.dart';
import 'package:lenore/application/provider/home_provider/home_banner_provider/home_banner_provider.dart';

import 'package:lenore/application/provider/login_provider/login_provider.dart';
import 'package:lenore/application/provider/mobile_number_provider/mobile_number_provider.dart';
import 'package:lenore/application/provider/new_aarival_provider/new_arrival_provider.dart';
import 'package:lenore/application/provider/otp_provider/otp_provider.dart';
import 'package:lenore/application/provider/gift_product_listing_provider/gift_product_listing_provider.dart';
import 'package:lenore/application/provider/product_detail_provider/product_detail_provider.dart';
import 'package:lenore/application/provider/product_listing_provider/product_listing_provder.dart';
import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';

import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';

import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';

import 'package:provider/provider.dart';

void main() {
  // Routes.initializeRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CheckBoxProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MobileNumberProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftByCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftByEventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CollectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftByVoucherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeBannerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftProductListingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BestSellerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewArrivalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BestsellerNewAarivalProductListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // routerConfig: Routes.router,

        // routerDelegate: Routes.router.routerDelegate,
        //routeInformationParser: Routes.router.routeInformationParser,
        home: const PersistantBottomNavBarScreen(),
        // home: OrderDetailScreen(),
        //home: AccountScreen(),
        // home: const SplashScreen(),
        //home: const BottomNaveBar(),
        //home: const CollectionScreen(),
        //home: const HomeScreen(),
        //home: GiftByEventScreen(),
        // home: const SplashScreen(),
        //home: const ProductDetailScreen(),
        // home: EditProfileScreen(),
      ),
    );
  }
}
