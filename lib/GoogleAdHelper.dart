import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsHelper {
  GoogleAdsHelper._();

  static final GoogleAdsHelper googleAdsHelper = GoogleAdsHelper._();

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  AppOpenAd? appOpenAd;
  NativeAd? nativeAd;
  bool  isAdLoaded = false;

  void showBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      // adUnitId: "ca-app-pub-3940256099942544/6300978111", // Testing ID
      adUnitId: "ca-app-pub-4466014673818612/7160668395",
      listener: BannerAdListener(
        onAdClosed: (Ad ad) {
          log("Ad Closed");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdLoaded: (Ad ad) {
          log('Ad Loaded');
        },
        onAdOpened: (Ad ad) {
          log('Ad opened');
        },
      ),
      request: const AdRequest(),
    );

    bannerAd?.load();
  }

  void showInterstitialAd() {
    int attempt = 0;
    InterstitialAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/1033173712", // Testing ID
      adUnitId: "ca-app-pub-4466014673818612/6125970087",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          attempt = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          attempt++;
          interstitialAd = null;
          if (attempt <= 2) {
            showInterstitialAd();
          }
        },
      ),
    );
  }

  void loadAppOpenAd() {
    AppOpenAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/9257395921", // Testing ID
      adUnitId: "ca-app-pub-4466014673818612/7404210971",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          showAppOpenAd();
        },
        onAdFailedToLoad: (error) {
          log("AppOpenAd failed to load: $error");
        },
      ),
    );
  }

  void showAppOpenAd() {
    if (appOpenAd != null) {
      appOpenAd!.show();
    } else {
      log(
          "AppOpenAd is not loaded yet. Call loadAppOpenAd() before showing.");
    }
  }
}
