import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper/controller/DatabaseHelper.dart';

class FullScreenImageController extends GetxController {
  final List<String> images;
  final RxInt currentIndex;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final RxList<String> likedImages = RxList<String>();

  FullScreenImageController({required this.images, required int initialIndex})
      : currentIndex = initialIndex.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLikedImages();
  }

  void fetchLikedImages() async {
    likedImages.assignAll(await databaseHelper.getLikedImages());
  }

  Future<void> downloadImage(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    if (statuses[Permission.storage]!.isGranted) {
      Dio dio = Dio();
      try {
        final tempDir = await getTemporaryDirectory();
        final path =
            '${tempDir.path}/downloadedImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
        var imageUrl = images[currentIndex.value];

        await dio.download(imageUrl, path);
        await ImageGallerySaver.saveFile(path);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black.withOpacity(.5),
            content: const Text(
              "Image downloaded successfully",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
      } catch (e) {
        log("$e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black.withOpacity(.5),
          content: const Text(
            "No permission to read and write.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  Future<void> setWallpaper(BuildContext context) async {
    String url = images[currentIndex.value];
    try {
      if (await Permission.storage.request().isGranted) {
        final tempDir = await getTemporaryDirectory();
        final path =
            '${tempDir.path}/tempImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await Dio().download(url, path);

        bool result = await AsyncWallpaper.setWallpaperFromFile(
          filePath: path,
          wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          goToHome: false,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result
              ? 'Wallpaper set successfully'
              : 'Failed to set wallpaper'),
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

  Future<void> shareImage(BuildContext context) async {
    String url = images[currentIndex.value];
    try {
      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/sharedImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Dio().download(url, path);

      Share.shareFiles([path],
          text:
              'Check out this cool wallpaper!\nFor more image: https://play.google.com/store/apps/details?id=com.wallscape.wallpaper&hl=en-IN');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while sharing: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> isLiked(String imageUrl) async {
    return await databaseHelper.isLiked(imageUrl);
  }

  Future<void> toggleLike(BuildContext context) async {
    String imageUrl = images[currentIndex.value];
    bool isCurrentlyLiked = await isLiked(imageUrl);

    if (isCurrentlyLiked) {
      await databaseHelper.delete(imageUrl);
    } else {
      await databaseHelper.insert(imageUrl);
    }
    fetchLikedImages();
  }
}
