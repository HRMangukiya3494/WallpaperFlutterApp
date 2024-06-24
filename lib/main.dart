import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper/model/RateUs.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  // try {
  //   GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
  // } catch (e) {
  //   log("$e");
  // }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {

    runApp(
      const MyApp(),
    );
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.INTRO,
      getPages: AppRoutes.routes,
    );
  }
}