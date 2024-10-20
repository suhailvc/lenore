import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

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
              customSizedBox(querySize),
              Text(
                'Wishlist',
                style: TextStyle(
                    color: const Color(0xFF008186),
                    fontSize: querySize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri'),
              ),
              customSizedBox(querySize),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: querySize.height * 0.015,
                  // mainAxisSpacing: querySize.height * 001,
                  childAspectRatio: 0.67,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: querySize.height * 0.2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E7E7),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: index % 2 == 0
                                ? const AssetImage(
                                    "assets/images/wishlist_one.png")
                                : const AssetImage(
                                    "assets/images/wishlist_two.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: querySize.height * 0.008,
                                  right: querySize.height * 0.012),
                              child: CircleAvatar(
                                radius: querySize.width * 0.033,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/home/favourite.png',
                                  width: querySize.width * 0.075,
                                  height: querySize.height * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: querySize.height * 0.01),
                      Text(
                        "Double Circle Necklace in\n10kt Yellow Gold",
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w600,
                          fontSize: querySize.width * 0.03,
                          color: const Color(0xFF353E4D),
                        ),
                      ),
                      SizedBox(
                        height: querySize.height * 0.007,
                      ),
                      Row(
                        children: [
                          Text(
                            "QAR",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            " 756",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/images/bag.png',
                            width: querySize.width * 0.088,
                            height: querySize.height * 0.028,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
