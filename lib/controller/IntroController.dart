import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';

class IntroController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offNamed(AppRoutes.BOTTOMNAVIGATION);
    }
  }
}