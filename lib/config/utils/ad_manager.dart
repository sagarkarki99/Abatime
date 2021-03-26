import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  Future<InitializationStatus> initialization;
  AdManager(this.initialization);

  String get bannerAdUnitId => 'ca-app-pub-3940256099942544/6300978111';
  String get appOpenAdUnitId => '	ca-app-pub-3940256099942544/3419835294';

  AdListener adListener = AdListener(
    
  );
}
