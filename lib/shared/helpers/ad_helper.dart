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

    return BannerAd(
      adUnitId: adUnitId,
      request: AdRequest(),
      size: AdSize.banner,
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

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/1033173712";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/4411468910";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/5224354917";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/1712485313";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
}
