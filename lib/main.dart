import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/GoogleAdHelper.dart';
import 'package:wallpaper/controller/CategoryController.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  try {
    GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
  } catch (e) {
    log("$e");
  }

  var status = await Permission.storage.request();
  if (status.isDenied) {
    await Permission.storage.request();
  }
  Get.put(CategoryController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? onTimeVisited = prefs.getBool('onTimeVisited');
    if (onTimeVisited == true) {
      runApp(
        const MyApp(
          homeRoute: AppRoutes.BOTTOMNAVIGATION,
        ),
      );
    } else {
      runApp(
        const MyApp(
          homeRoute: AppRoutes.INTRO,
        ),
      );
    }
  });
}

class MyApp extends StatelessWidget {
  final String homeRoute;
  const MyApp({required this.homeRoute, super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      getPages: AppRoutes.routes,
    );
  }
}
