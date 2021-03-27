import 'package:flutter/material.dart';
import '../widgets/ads_widgets/banner_widget.dart';
import '../widgets/ads_widgets/native_ad_widget.dart';

class AdDemoScreen extends StatefulWidget {
  @override
  _AdDemoScreenState createState() => _AdDemoScreenState();
}

class _AdDemoScreenState extends State<AdDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BannerWidget(),
        NativeAdWidget(),
      ],
    );
  }
}
