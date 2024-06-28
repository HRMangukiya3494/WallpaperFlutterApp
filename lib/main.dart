import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/controller/CategoryController.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  // try {
  //   GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
  // } catch (e) {
  //   log("$e");
  // }
  var status = await Permission.storage.request();
  if (status.isDenied) {
    await Permission.storage.request();
  }
  Get.put(
    CategoryController(),
  );
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
