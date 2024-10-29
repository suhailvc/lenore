import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

var baseUrl = "https://project.artisans.qa/lenore-latest";
Color appColor = const Color(0xFF00ACB3);
Color textColor = const Color(0xFF008186);
SizedBox customSizedBox(Size querySize) {
  return SizedBox(
    height: querySize.height * 0.02,
  );
}

SizedBox customOneSizedBox(Size querySize) {
  return SizedBox(
    height: querySize.height * 0.02,
  );
}

Divider customDivider(Size querySize) {
  return Divider(
    color: Colors.black.withOpacity(0.25), // 25% opacity
    thickness: 0.6,
    indent: querySize.height * 0.048,
    endIndent: querySize.height * 0.048,
  );
}

SizedBox customHeightThree(Size querySize) {
  return SizedBox(
    height: querySize.height * 0.03,
  );
}

var voucherPrice = [
  '1000 QR',
  '1500 QR',
  '2000 QR',
  '2500 QR',
  '3000 QR',
  '3000 QR',
  '4000 QR',
  '4500 QR',
];

Size querySizeMethod(BuildContext context) {
  var querySize = MediaQuery.of(context).size;
  return querySize;
}

var giftByCateogryListName = ['DIAMOND', 'GOLD', 'SILVER', 'PEARL', 'SETS'];
var giftByCateogryListPhotos = [
  'assets/images/home/diamond_earing.png',
  'assets/images/home/diamond_earing.png',
  'assets/images/home/diamond_earing.png',
  'assets/images/home/diamond_earing.png',
  'assets/images/home/diamond_earing.png',
];
var collectionListName = ['LAURA', 'ZRI', 'WARDA', 'ZRI', 'WARDA', 'LAURA'];
var collectionListPhotos = [
  'assets/images/home/collection.png',
  'assets/images/home/collection.png',
  'assets/images/home/collection.png',
  'assets/images/home/collection.png',
  'assets/images/home/collection.png',
  'assets/images/home/collection.png',
];
var homeBanner = [
  "assets/images/home_screen_slider_image_one.png",
  "assets/images/home/home_banner_2.png",
  "assets/images/home/home_banner_3.png"
];
Container lenoreGif(Size querySize) {
  return Container(
    color: Colors.white,
    height: querySize.height * 0.7,
    width: querySize.width * 1,
    child: Center(
      child: Image.asset(
        'assets/images/Lenore.gif',
        height: querySize.height * 0.3,
        width: querySize.width * 0.4,
      ).animate(),
    ),
  );
}
