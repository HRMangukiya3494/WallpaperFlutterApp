import 'package:get/get.dart';
import 'package:wallpaper/views/screen/AboutUsPage.dart';
import 'package:wallpaper/views/screen/BottomNavigationPage.dart';
import 'package:wallpaper/views/screen/CategoryPage.dart';
import 'package:wallpaper/views/screen/ColorfulListPage.dart';
import 'package:wallpaper/views/screen/ColorfulPage.dart';
import 'package:wallpaper/views/screen/FeaturesPage.dart';
import 'package:wallpaper/views/screen/HomePage.dart';
import 'package:wallpaper/views/screen/IntroScreen.dart';
import 'package:wallpaper/views/screen/LikePage.dart';
import 'package:wallpaper/views/screen/NewPage.dart';
import 'package:wallpaper/views/screen/PrivacyPolicyPage.dart';
import 'package:wallpaper/views/screen/SearchPage.dart';
import 'package:wallpaper/views/screen/TrendingPage.dart';

class AppRoutes {
  static const INTRO = '/';
  static const HOME = '/home';
  static const PRIVACYPOLICY = '/privacy_policy';
  static const ABOUTUS = '/about_us';
  static const SEARCH = '/search';
  static const BOTTOMNAVIGATION = '/bottom';
  static const CATEGORY = '/category';
  static const LIKE = '/like';
  static const FEATURES = '/features';
  static const COLORFUL = '/colorful';
  static const NEW = '/new';
  static const TRENDING = '/trading';
  static const COLORFULLIST = '/colorful_list';

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
    GetPage(
      name: FEATURES,
      page: () => FeaturesPage(),
    ),
    GetPage(
      name: COLORFUL,
      page: () => ColorfulPage(),
    ),
    GetPage(
      name: NEW,
      page: () => NewPage(),
    ),
    GetPage(
      name: TRENDING,
      page: () => TrendingPage(),
    ),
    GetPage(
      name: COLORFULLIST,
      page: () => ColorfulListPage(),
    ),
  ];
}
