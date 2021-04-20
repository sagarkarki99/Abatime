import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  Future<InitializationStatus> initialization;
  AdManager(this.initialization);

   String testNativeAdId = 'ca-app-pub-3940256099942544/2247696110';
  String liveNativeAdId = 'ca-app-pub-4483204795222749/4742061101';

  String liveBannerAdId = 'ca-app-pub-4483204795222749/9057772722';
  String testBannerAdId = 'ca-app-pub-3940256099942544/6300978111'; 

  String get bannerAdUnitId => liveBannerAdId;
  String get appOpenAdUnitId => 'ca-app-pub-3940256099942544/3419835294';
  String get nativeAdUnitId => liveNativeAdId;
  String get nativeVideoAdUnitId => 'ca-app-pub-3940256099942544/1044960115';

  AdListener adListener = AdListener();
}
