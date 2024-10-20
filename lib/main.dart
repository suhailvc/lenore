import 'package:flutter/material.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/application/provider/login_provider/login_provider.dart';

import 'package:lenore/presentation/screens/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:lenore/presentation/screens/filter_screen/filter_screen.dart';
import 'package:lenore/presentation/screens/home/home_screen.dart';
import 'package:lenore/presentation/screens/payment_screen/payment_screen.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:lenore/presentation/screens/splash/splash_screen.dart';
import 'package:lenore/sample.dart';

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
        // home: const PersistantBottomNavBarScreen(),
        // home: OrderDetailScreen(),
        //home: AccountScreen(),
        // home: const SplashScreen(),
        //home: const BottomNaveBar(),
        //home: const CollectionScreen(),
        //home: const HomeScreen(),
        //home: GiftByEventScreen(),
        home: const SplashScreen(),
        //home: const ProductDetailScreen(),
        // home: EditProfileScreen(),
      ),
    );
  }
}
