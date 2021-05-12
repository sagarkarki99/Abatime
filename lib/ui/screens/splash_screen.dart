import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SplashIcon(),
            _SplashText(),
          ],
        ),
      ),
    );
  }
}

class _SplashIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Colors.purple.shade400,
            Colors.purple.shade900,
          ],
        ).createShader(bounds);
      },
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.purple,
        period: Duration(
          seconds: 2,
        ),
        child: Icon(
          FluentIcons.tv_48_filled,
          size: 128,
        ),
      ),
    );
  }
}

class _SplashText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black,
      highlightColor: Colors.white,
      period: Duration(
        seconds: 2,
      ),
      child: Text(
        'Aba Time',
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
