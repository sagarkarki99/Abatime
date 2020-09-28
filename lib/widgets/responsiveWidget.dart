import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  ResponsiveWidget({Key key, this.mobile, this.tablet}) : super(key: key);

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 500;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 500) {
        print(constraints.maxWidth);
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
