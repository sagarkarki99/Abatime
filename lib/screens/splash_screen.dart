import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
          body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.black,
          highlightColor: Colors.white,
          period: Duration(
            seconds: 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.tv_rounded,
                size: 62,
              ),
              Text(
                'Aba Time',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
