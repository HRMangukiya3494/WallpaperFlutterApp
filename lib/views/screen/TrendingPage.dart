import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/TrendingController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class TrendingPage extends StatelessWidget {
  final TrendingController trendingController = Get.put(TrendingController(),);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Trending",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.PrimaryColor,
            fontSize: h * 0.026,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(h * 0.02),
        child: Obx(() {
          if (trendingController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: h * 0.02,
              crossAxisSpacing: h * 0.02,
              itemCount: trendingController.wallpapers.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                       trendingController.wallpapers[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                );
              },
            );
          }
        }),
      ),
    );
  }
}
