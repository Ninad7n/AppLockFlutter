// import 'dart:developer';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AddRepo {
//   AdManagerBannerAd? banner1;

//   loadAdds() {
//     getAddBanner("f").load();
//   }

//   AdManagerBannerAd getAddBanner(id) {
//     return banner1 = AdManagerBannerAd(
//       adUnitId: '$id',
//       sizes: [AdSize.banner],
//       request: const AdManagerAdRequest(),
//       listener: listener,
//     );
//   }

//   final AdManagerBannerAdListener listener = AdManagerBannerAdListener(
//     onAdLoaded: (Ad ad) => log('Ad loaded.'),
//     onAdFailedToLoad: (Ad ad, LoadAdError error) {
//       ad.dispose();
//       log('Ad failed to load: $error');
//     },
//     onAdOpened: (Ad ad) => log('Ad opened.'),
//     onAdClosed: (Ad ad) => log('Ad closed.'),
//     onAdImpression: (Ad ad) => log('Ad impression.'),
//   );
// }
