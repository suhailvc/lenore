// Column customCarouselSlider(Size querySize) {
//   return Column(
//     children: [
//       CarouselSlider.builder(
//           itemCount: homeBanner.length,
//           itemBuilder: (context, index, realIndex) {
//             return Container(
//               margin: EdgeInsets.only(right: querySize.width * 0.025),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(querySize.height * 0.01),
//                 image: DecorationImage(
//                   image: AssetImage(homeBanner[index]),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//           options: CarouselOptions(
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   activeIndex = index;
//                 });
//               },
//               viewportFraction: 1,
//               height: querySize.height * 0.24,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 4))),
//       SizedBox(
//         height: querySize.height * 0.01,
//       ),
//       AnimatedSmoothIndicator(
//         activeIndex: activeIndex,
//         count: homeBanner.length,
//         effect: SlideEffect(
//             dotHeight: querySize.height * 0.008,
//             dotWidth: querySize.width * 0.018,
//             activeDotColor: appColor),
//       )
//     ],
//   );
// }
