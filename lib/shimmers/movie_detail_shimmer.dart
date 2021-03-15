import 'package:abatime/shimmers/base_shimmer.dart';
import 'package:abatime/shimmers/shimmer_item.dart';
import 'package:flutter/material.dart';

class MovieDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return BaseShimmer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShimmerItem(width: 150, height: 200),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerItem(
                        height: 20,
                        width: 100,
                      ),
                      SizedBox(height: 8.0),
                      ShimmerItem(
                        height: 20,
                        width: 70,
                      ),
                      SizedBox(height: 8.0),
                      ShimmerItem(
                        height: 50,
                        width: 120,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: ShimmerItem(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.70,
              ),
            ),
            Row(
              children: [
                ShimmerItem(
                  height: 30,
                  width: 100,
                ),
                ShimmerItem(
                  height: 30,
                  width: 60,
                ),
                ShimmerItem(
                  height: 30,
                  width: 90,
                ),
              ],
            ),
            ShimmerItem(
              width: width * 0.90,
              height: 15,
            ),
            ShimmerItem(
              width: width * 0.20,
              height: 15,
            ),
            ShimmerItem(
              width: width * 0.40,
              height: 15,
            ),
            ShimmerItem(
              width: width * 0.70,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
