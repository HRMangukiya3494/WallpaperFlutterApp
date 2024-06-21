import 'package:get/get.dart';
import 'package:wallpaper/views/screen/HomePage.dart';
import 'package:wallpaper/views/screen/IntroScreen.dart';

class AppRoutes {
  static const INTRO = '/';
  static const HOME = '/home';

  static final routes = [
    GetPage(
      name: INTRO,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
  ];
}