import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer ShimmerLoading({required double containerHeight}) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
      ));
}
