import 'package:AbaTime/shimmers/baseShimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TvShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
            baseColor: Colors.white70,
            period: Duration(seconds: 2),
            highlightColor:
                Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
            child: Text(
              'Coming Soon',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white, letterSpacing: 2),
            )),
      ),
    );
  }
}
