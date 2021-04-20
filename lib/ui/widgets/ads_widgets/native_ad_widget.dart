import 'package:abatime/config/utils/ad_manager.dart';
import 'package:abatime/shimmers/shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class NativeAdWidget extends StatefulWidget {
  @override
  _NativeAdWidgetState createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd nativeAd;
  bool isAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adManager = Provider.of<AdManager>(context);
    adManager.initialization.then((value) => {
          setState(() {
            nativeAd = NativeAd(
              adUnitId: adManager.nativeAdUnitId,
              factoryId: 'nativeAd',
              listener: AdListener(
                onAdLoaded: (ad) {
                  
                  setState(() {
                    isAdLoaded = true;
                  });
                },
                onAdClosed: (ad) {
                  
                },
                onAdFailedToLoad: (ad, error) {
                  
                  ad.dispose();
                },
              ),
              request: AdRequest(),
            )..load();
          })
        });
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isAdLoaded
        ? ShimmerItem()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 170,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: AdWidget(ad: nativeAd),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('8.9'),
                      Icon(
                        FluentIcons.star_24_filled,
                        size: 18,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  )),
            ],
          );
  }
}
