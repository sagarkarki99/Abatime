import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  Future<InitializationStatus> initialization;
  AdManager(this.initialization);

   String testNativeAdId = 'ca-app-pub-3940256099942544/2247696110';
  String liveNativeAdId = 'ca-app-pub-4483204795222749/4742061101';

  String liveBannerAdId = 'ca-app-pub-4483204795222749/5058514040';

  String get bannerAdUnitId => liveBannerAdId;
  String get nativeAdUnitId => liveNativeAdId;

  AdListener adListener = AdListener();
}
