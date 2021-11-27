import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '/shared/core/build_configs.dart';

/// Helper that get the ad keys according to the plataforms
abstract class AdHelper {
  /// Admob Trade Operation
  static String get interstitialTradeOperation {
    if (Platform.isAndroid) {
      return Config.admobInterstitialTradeOperationAndroid;
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  /// Admob Trade Register
  static BannerAd bannerTradeRegisterAndDetails({AdSize size = AdSize.banner}) {
    String adUnitId;
    if (Platform.isAndroid) {
      adUnitId = Config.admobBannerTradeRegisterAndDetailsAndroid;
    } else if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }

    return _getBannerAd(adUnitId: adUnitId, size: size);
  }

  /// Admob Trade List key
  static BannerAd get bannerTradesList {
    String adUnitId;
    if (Platform.isAndroid) {
      adUnitId = Config.admobBannerTradeRegisterAndDetailsAndroid;
    } else if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }

    return _getBannerAd(adUnitId: adUnitId);
  }

  /// Admob Wallet Coins List key
  static BannerAd get bannerWalletCoinsList {
    String adUnitId;
    if (Platform.isAndroid) {
      adUnitId = Config.admobBannerTradeRegisterAndDetailsAndroid;
    } else if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }

    return _getBannerAd(adUnitId: adUnitId, size: AdSize.largeBanner);
  }

  static BannerAd _getBannerAd({
    required String adUnitId,
    AdSize size = AdSize.banner,
  }) {
    return BannerAd(
      adUnitId: adUnitId,
      request: AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdClosed: (ad) {
          ad.dispose();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
  }
}
