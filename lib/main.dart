import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lenore/application/provider/add_to_wishlist_provider/add_to_wishlist_provider.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/bestseller_new_aarival_product_list_provider/bestseller_new_aarival_product_list_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
import 'package:lenore/application/provider/customization_provider/customization_provider.dart';

import 'package:lenore/application/provider/edit_profile_provider/edit_profile_provider.dart';
import 'package:lenore/application/provider/get_wishlist_provider/get_wishlist_provider.dart';
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
import 'package:lenore/application/provider/notification_provider/notification_provider.dart';
import 'package:lenore/application/provider/order_detail_provider/order_detail_provider.dart';
import 'package:lenore/application/provider/order_history_provider/order_history_provider.dart';
import 'package:lenore/application/provider/otp_provider/otp_provider.dart';
import 'package:lenore/application/provider/gift_product_listing_provider/gift_product_listing_provider.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/application/provider/product_detail_provider/product_detail_provider.dart';
import 'package:lenore/application/provider/product_listing_provider/product_listing_provder.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/application/provider/repair_provider/repair_provider.dart';
import 'package:lenore/application/provider/search_provider/search_provider.dart';
import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';

import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';
import 'package:lenore/application/provider/voucher_detail_provider/voucher_detail_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/presentation/screens/landing_screen/landing_screen.dart';

import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:lenore/presentation/screens/search_screen/search_screen.dart';
import 'package:lenore/presentation/screens/splash/splash_screen.dart';
import 'package:lenore/presentation/widgets/shimmer_widget.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HiveCartModelAdapter().typeId)) {
    Hive.registerAdapter(HiveCartModelAdapter());
  }
  await Hive.openBox<HiveCartModel>('cartBox');
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
        ChangeNotifierProvider(
          create: (context) => CustomizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckOutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VocherDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddToWishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetWishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RepairProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
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
        //  home: const PersistantBottomNavBarScreen(),
        //  home: LandingScreen(),
        //home: AccountScreen(),
        // home: const SplashScreen(),
        //home: const BottomNaveBar(),
        //home: const CollectionScreen(),
        //home: const HomeScreen(),
        // home: PersistantBottomNavBarScreen(),
        home: const SplashScreen(),
        // home: const ShimmerLoading(
        //     itemCount: itemCount, containerHeight: containerHeight),
        // home: EditProfileScreen(),
      ),
    );
  }
}
