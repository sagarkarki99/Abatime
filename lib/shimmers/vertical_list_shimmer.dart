import 'package:abatime/shimmers/base_shimmer.dart';
import 'package:abatime/shimmers/shimmer_item.dart';
import 'package:flutter/material.dart';

class VerticalListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        child: ListView(
          children: [
            ...List.generate(4, (int index) => VerticalListItem()).toList(),
          ],
        ),
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerItem(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.80,
          ),
          ShimmerItem(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.20,
          ),
        ],
      ),
    );
  }
}
