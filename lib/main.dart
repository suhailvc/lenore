import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lenore/application/localization/localization.dart';
import 'package:lenore/application/provider/add_to_wishlist_provider/add_to_wishlist_provider.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/bestseller_new_aarival_product_list_provider/bestseller_new_aarival_product_list_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
import 'package:lenore/application/provider/customization_provider/customization_provider.dart';
import 'package:lenore/application/provider/delivery_fee_provider/delivery_fee_provider.dart';

import 'package:lenore/application/provider/edit_profile_provider/edit_profile_provider.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/get_wishlist_provider/get_wishlist_provider.dart';
import 'package:lenore/application/provider/gold_purity_provider/gold_purity_provider.dart';
import 'package:lenore/application/provider/home_provider/best_seller_provider/best_seller_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';

import 'package:lenore/application/provider/home_provider/collection_provider/collection_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_category/gift_by_category_provider.dart';

import 'package:lenore/application/provider/home_provider/gift_by_event_provider/gift_by_event_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_voucher_provider/gift_by_voucher_provider.dart';
import 'package:lenore/application/provider/home_provider/home_banner_provider/home_banner_provider.dart';
import 'package:lenore/application/provider/locale_provider/locale_provider.dart';

import 'package:lenore/application/provider/login_provider/login_provider.dart';
import 'package:lenore/application/provider/mobile_number_provider/mobile_number_provider.dart';
import 'package:lenore/application/provider/new_aarival_provider/new_arrival_provider.dart';
import 'package:lenore/application/provider/notification_provider/notification_provider.dart';
import 'package:lenore/application/provider/off_days_provider/off_days_provider.dart';
import 'package:lenore/application/provider/order_detail_provider/order_detail_provider.dart';
import 'package:lenore/application/provider/order_history_provider/order_history_provider.dart';
import 'package:lenore/application/provider/order_status_provider/order_status_provider.dart';
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
import 'package:lenore/application/provider/wallet_balance_provider/wallet_balance_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/firebase_options.dart';

import 'package:lenore/presentation/screens/splash/splash_screen.dart';
import 'package:lenore/push_notification.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

AndroidNotificationChannel? channel;
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HiveCartModelAdapter().typeId)) {
    Hive.registerAdapter(HiveCartModelAdapter());
  }
  await Hive.openBox<HiveCartModel>('cartBox');
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessaging.instance.subscribeToTopic('grofresh');
  if (defaultTargetPlatform == TargetPlatform.android) {
    FirebaseMessaging.instance.requestPermission();

    /// firebase crashlytics
  }
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('-------fcm token-----  $fcmToken');
  fcm_token = fcmToken;
  int? orderID;
  try {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        description: 'Important notifications from the app', // Add description
      );
    }
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      orderID = remoteMessage.notification!.titleLocKey != null
          ? int.parse(remoteMessage.notification!.titleLocKey!)
          : null;
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  } catch (e) {
    if (kDebugMode) {
      print('error---> ${e.toString()}');
    }
  }
  // Initialize MFSDK with proper error handling
  // try {
  //   debugPrint("Initializing MFSDK...");
  //   await MFSDK.init(
  //     "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
  //     MFCountry.KUWAIT,
  //     MFEnvironment.TEST,
  //   );
  //   debugPrint("MFSDK initialized successfully");
  // } catch (e) {
  //   debugPrint("Error initializing MFSDK: $e");
  // }

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
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoldPurityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeliveryFeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderStatusProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OffDaysProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletBalanceProvider(),
        ),
      ],
      child:
          Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
