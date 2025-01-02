import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer multipleShimmerLoading({required double containerHeight}) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              )
            ],
          );
        },
      ));
}
