import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;

  const BaseShimmer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
      highlightColor: Theme.of(context).secondaryHeaderColor,
      child: child,
    );
  }
}
