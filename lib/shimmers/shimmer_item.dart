import 'package:flutter/material.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerItem({Key key, this.height = 170, this.width = 120})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
