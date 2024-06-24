import 'package:get/get.dart';
import 'package:wallpaper/views/screen/AboutUsPage.dart';
import 'package:wallpaper/views/screen/BottomNavigationPage.dart';
import 'package:wallpaper/views/screen/CategoryPage.dart';
import 'package:wallpaper/views/screen/HomePage.dart';
import 'package:wallpaper/views/screen/IntroScreen.dart';
import 'package:wallpaper/views/screen/LikePage.dart';
import 'package:wallpaper/views/screen/PrivacyPolicyPage.dart';
import 'package:wallpaper/views/screen/SearchPage.dart';

class AppRoutes {
  static const INTRO = '/';
  static const HOME = '/home';
  static const PRIVACYPOLICY = '/privacy_policy';
  static const ABOUTUS = '/about_us';
  static const SEARCH = '/search';
  static const BOTTOMNAVIGATION = '/bottom';
  static const CATEGORY = '/category';
  static const LIKE = '/like';

  static final routes = [
    GetPage(
      name: INTRO,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: BOTTOMNAVIGATION,
      page: () => BottomNavigationPage(),
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
    GetPage(
      name: SEARCH,
      page: () => SearchPage(),
    ),
    GetPage(
      name: CATEGORY,
      page: () => CategoryPage(),
    ),
    GetPage(
      name: LIKE,
      page: () => LikePage(),
    ),
  ];
}