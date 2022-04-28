import 'package:flutter/material.dart';

class ScreenTransition extends PageRouteBuilder {
  final Widget? page;

  ScreenTransition({this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page!,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut
                ),
              ),
              child: child,
            );
          },
        );
}
