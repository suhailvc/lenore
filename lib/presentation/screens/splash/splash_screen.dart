import 'package:flutter/material.dart';

import 'package:lenore/presentation/screens/splash/widgets/custom_timer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    wait(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash.png",
            width: querySize.width * 0.45, // Set the desired width
            height: querySize.height * 0.4,
          )
        ],
      ),
    );
  }
}
