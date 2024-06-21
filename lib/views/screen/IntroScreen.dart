import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/IntroController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class IntroScreen extends StatelessWidget {
  final IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: introController.pageController,
              onPageChanged: introController.onPageChanged,
              children: [
                buildPage(
                    h,
                    w,
                    'assets/images/IntroVector1.png',
                    'Artistry Unleashed: Discover, Create, and Personalize',
                    'Unlock a world of artistic wallpapers, create your own designs, and personalize your device with style.',
                    introController
                ),
                buildPage(
                    h,
                    w,
                    'assets/images/IntroVector2.png',
                    'Immersive Themes: Customize Your Device with Ease',
                    'Immerse yourself in a variety of themes, from nature to abstract art, and effortlessly personalize your screen.',
                    introController
                ),
                buildPage(
                    h,
                    w,
                    'assets/images/IntroVector3.png',
                    'Daily Inspiration: Fresh Wallpapers Every Day',
                    'Get inspired daily with a diverse selection of high-resolution wallpapers curated to refresh your device seamlessly.',
                    introController
                ),
              ],
            ),
          ),
          Obx(() => GestureDetector(
            onTap: introController.nextPage,
            child: Container(
              height: h * 0.06,
              width: w * 0.8,
              margin: EdgeInsets.only(bottom: h * 0.04),
              decoration: BoxDecoration(
                color: ColorUtils.PrimaryColor,
                borderRadius: BorderRadius.circular(h * 0.02),
              ),
              child: Center(
                child: Text(
                  introController.currentPage.value == 2 ? "Get Started" : "Continue",
                  style: TextStyle(
                    fontSize: h * 0.024,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget buildPage(double height, double width, String imagePath, String title,
      String description, IntroController introController) {
    return Padding(
      padding: EdgeInsets.all(height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: height * 0.1),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.026,
              color: ColorUtils.PrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.02),
          Text(
            description,
            style: TextStyle(
              fontSize: height * 0.02,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
