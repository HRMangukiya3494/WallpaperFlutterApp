import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/ColorfulListController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class ColorfulListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    final args = Get.arguments;
    if (args != null &&
        args is Map<String, dynamic> &&
        args.containsKey('cid') &&
        args.containsKey('color')) {
      final colorfulListController = Get.put(
        ColorfulListController(
          cid: int.tryParse(args['cid'] ?? '') ?? 0,
          color: args['color'] ?? '',
        ),
      );

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
            args['color'] ?? "",
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
            if (colorfulListController.wallpapers.isEmpty && colorfulListController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    colorfulListController.fetchWallpapers();
                  }
                  return false;
                },
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: h * 0.02,
                  crossAxisSpacing: h * 0.02,
                  itemCount: colorfulListController.wallpapers.length + (colorfulListController.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == colorfulListController.wallpapers.length) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    var wallpaperInfo = colorfulListController.wallpapers[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 0.02),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://hdwalls.wallzapps.com/upload/custom/" +
                                wallpaperInfo['images'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                      width: double.infinity,
                    );
                  },
                ),
              );
            }
          }),
        ),
      );
    } else {
      log('Error: Missing or invalid arguments');
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid arguments'),
        ),
      );
    }
  }
}
