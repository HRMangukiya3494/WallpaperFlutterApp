import 'package:get/get.dart';
import 'package:wallpaper/views/screen/AboutUsPage.dart';
import 'package:wallpaper/views/screen/HomePage.dart';
import 'package:wallpaper/views/screen/IntroScreen.dart';
import 'package:wallpaper/views/screen/PrivacyPolicyPage.dart';

class AppRoutes {
  static const INTRO = '/';
  static const HOME = '/home';
  static const PRIVACYPOLICY = '/privacy_policy';
  static const ABOUTUS = '/about_us';

  static final routes = [
    GetPage(
      name: INTRO,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: PRIVACYPOLICY,
      page: () => PrivacyPolicyPage(),
    ),
    GetPage(
      name: ABOUTUS,
      page: () => AboutUsPage(),
    ),
  ];
}