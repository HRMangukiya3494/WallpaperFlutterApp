import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/ColorfulListController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class ColorfulListPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  ColorfulListPage({required this.arguments});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    ColorfulListController colorfulListController;

    final args = Get.arguments;
    if (args != null &&
        args is Map<String, dynamic> &&
        args.containsKey('cid') &&
        args.containsKey('color')) {
      colorfulListController = Get.put(
        ColorfulListController(
          cid: int.tryParse(args['cid'] ?? '') ?? 0,
          color: args['color'] ?? '',
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
          arguments['color'] ?? "",
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
          if (colorfulListController.wallpapers.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: h * 0.02,
                crossAxisSpacing: h * 0.02,
              ),
              itemCount: colorfulListController.wallpapers.length,
              itemBuilder: (context, index) {
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
                  height: h * 0.3,
                  width: double.infinity,
                );
              },
            );
          }
        }),
      ),
    );
  }
}
