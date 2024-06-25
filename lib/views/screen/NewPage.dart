import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/NewController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class NewPage extends StatelessWidget {
  final NewController controller = Get.put(
    NewController(),
  );

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
          "New",
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
          if (controller.isLoading.value &&
              controller.wallpapers.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                controller.fetchWallpapers();
                return true;
              }
              return false;
            },
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: h * 0.02,
              crossAxisSpacing: h * 0.02,
              itemCount: controller.wallpapers.length,
              itemBuilder: (context, index) {
                var wallpaper = controller.wallpapers[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h * 0.01),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://hdwalls.wallzapps.com/upload/custom/' +
                            wallpaper['image'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
