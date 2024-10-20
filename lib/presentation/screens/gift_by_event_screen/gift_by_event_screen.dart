import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_event_card.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class GiftByEventScreen extends StatelessWidget {
  const GiftByEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customOneSizedBox(querySize),
              customTopBar(querySize, context),
              customHeightThree(querySize),
              Text(
                'Gift by event',
                style: TextStyle(
                    color: const Color(0xFF008186),
                    fontSize: querySize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri'),
              ),
              customSizedBox(querySize),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.1,
                children: [
                  buildEventCard("assets/images/home/Birth Day.png", "Birthday",
                      querySize, context),
                  buildEventCard("assets/images/home/ramdan.png", "Ramadan",
                      querySize, context),
                  buildEventCard("assets/images/home/New Born.png", "New Born",
                      querySize, context),
                  buildEventCard("assets/images/home/Graduation.png",
                      "Graduation", querySize, context),
                  buildEventCard(
                      "assets/images/home/eid.png", "Eid", querySize, context),
                  buildEventCard("assets/images/home/wedding.png", "Wedding",
                      querySize, context),
                  buildEventCard("assets/images/home/omra.png", "Omra",
                      querySize, context),
                  buildEventCard("assets/images/home/thankyou.png", "Thank you",
                      querySize, context),
                  buildEventCard("assets/images/home/Birth Day.png", "Birthday",
                      querySize, context),
                  buildEventCard("assets/images/home/ramdan.png", "Ramadan",
                      querySize, context),
                  buildEventCard("assets/images/home/New Born.png", "New Born",
                      querySize, context),
                  buildEventCard("assets/images/home/Graduation.png",
                      "Graduation", querySize, context),
                  buildEventCard(
                      "assets/images/home/eid.png", "Eid", querySize, context),
                  buildEventCard("assets/images/home/wedding.png", "Wedding",
                      querySize, context),
                  buildEventCard("assets/images/home/omra.png", "Omra",
                      querySize, context),
                  buildEventCard("assets/images/home/thankyou.png", "Thank you",
                      querySize, context),
                ],
              ),
            ],
          ),
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       height: querySize.height * 0.03,
        //     ),
        //     const CustomAppABr(),
        //     customSizedBox(querySize),
        //     Center(
        //       child: Column(
        //         children: [
        //           Image.asset(
        //             'assets/images/gift_by_event/Lenore jewellery image.png',
        //             width: querySize.width * 0.1,
        //             height: querySize.height * 0.1,
        //           ),
        //           const Text(
        //             "Lenore Jewellery",
        //             style: TextStyle(fontSize: 15, color: Color(0xFF00ACB3)
        //                 // fontFamily: 'Swis',
        //                 ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //       height: querySize.height * 0.06,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.13),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Gift By Event",
        //             style: TextStyle(
        //               fontSize: querySize.height * 0.029,
        //               fontFamily: 'Sitka',
        //               fontWeight: FontWeight.bold,
        //               color: const Color(0xFF08777B),
        //             ),
        //           ),
        //           SizedBox(
        //             height: querySize.height * 0.001,
        //           ),
        //           Text(
        //             "Choose your gift according\nTo the occasionnn",
        //             style: TextStyle(
        //               fontSize: querySize.height * 0.014, fontFamily: 'Segoe',
        //               // fontFamily: 'Swis',
        //               color: Colors.black,
        //             ),
        //           ),
        //           SizedBox(
        //             height: querySize.height * 0.04,
        //           ),
        //           GridView.builder(
        //             physics: const NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             itemCount: 12,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 4,
        //               crossAxisSpacing: querySize.height * 0.02,
        //               mainAxisSpacing: querySize.height * 0.04,
        //               childAspectRatio: 0.9,
        //             ),
        //             itemBuilder: (context, index) {
        //               return buildEventCard(giftEventItems[index]["imagePath"]!,
        //                   giftEventItems[index]["name"]!, querySize, context);
        //             },
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      )),
    );
  }
}
