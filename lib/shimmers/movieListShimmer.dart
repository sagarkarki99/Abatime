import 'package:AbaTime/shimmers/baseShimmer.dart';
import 'package:AbaTime/shimmers/shimmerItem.dart';
import 'package:flutter/material.dart';

class MovieListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ShimmerItem(),
          ShimmerItem(),
          ShimmerItem(),
        ],
      ),
    ));
  }
}
