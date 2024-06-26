import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

class FullScreenImageController extends GetxController {
  final List<String> images;
  final RxInt currentIndex;

  FullScreenImageController({required this.images, required int initialIndex})
      : currentIndex = initialIndex.obs;

  Future<void> setWallpaper(BuildContext context) async {
    String url = images[currentIndex.value];
    try {
      // Request necessary permissions
      if (await Permission.storage.request().isGranted) {
        // Download the image to a temporary directory
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/tempImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await Dio().download(url, path);

        // Set the downloaded image as wallpaper
        bool result = await AsyncWallpaper.setWallpaperFromFile(
          filePath: path,
          wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          goToHome: false,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result ? 'Wallpaper set successfully' : 'Failed to set wallpaper'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
