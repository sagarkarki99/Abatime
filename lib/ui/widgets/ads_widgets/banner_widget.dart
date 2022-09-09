import 'package:abatime/config/utils/ad_manager.dart';
import 'package:abatime/shimmers/shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adManager = Provider.of<AdManager>(context);
    adManager.initialization.then((value) => setState(() {
          bannerAd = BannerAd(
            adUnitId: adManager.bannerAdUnitId,
            size: AdSize.banner,
            request: AdRequest(),
            listener: adManager.bannerAdListener,
          )..load();
        }));
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bannerAd == null
        ? SizedBox.shrink()
        : Container(
            height: 50,
            child: AdWidget(
              ad: bannerAd!,
            ),
          );
  }
}
