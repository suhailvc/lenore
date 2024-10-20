import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

customEventMessageField(Size querySize) {
  return SizedBox(
    height: querySize.height * 0.28,
    // child: CarouselSlider(items: [], options: CarouselOptions(height: 300)),
    child: ListView.builder(
      physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              // if (index == 0) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ,
              //       ));
              // }
              // if (index == 1) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //
              //     ));
              // }
              // if (index == 2) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ,
              //     ));
              // }
              // if (index == 3) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           ,
              //     ));
              //  }
            },
            child: Container(
              margin: EdgeInsets.only(right: querySize.width * 0.025),
              width: 341.16 / 375.0 * querySize.width,
              // height: 200.7 / 812.0 * querySize.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(querySize.height * 0.01),
                image: DecorationImage(
                  image: AssetImage(homeBanner[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ));
      },
    ),
  );
}

customCarouselSlider(Size querySize) {
  CarouselSlider.builder(
      itemCount: homeBanner.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: EdgeInsets.only(right: querySize.width * 0.025),
          width: 341.16 / 375.0 * querySize.width,
          // height: 200.7 / 812.0 * querySize.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(querySize.height * 0.01),
            image: DecorationImage(
              image: AssetImage(homeBanner[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(height: 400));
}
