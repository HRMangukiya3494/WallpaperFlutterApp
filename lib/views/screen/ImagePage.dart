import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallpaper/controller/FullScreenImageController.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImagePage({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    final FullScreenImageController controller = Get.put(
        FullScreenImageController(images: images, initialIndex: initialIndex));
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              aspectRatio: 1.0,
              initialPage: initialIndex,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              scrollPhysics: BouncingScrollPhysics(),
              onPageChanged: (index, reason) {
                controller.currentIndex.value = index;
              },
            ),
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      image,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageUtils.ImagePath +
                                    ImageUtils.HomeWallpaper1,
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: h * 0.02,
              right: h * 0.02,
              top: h * 0.06,
              bottom: h * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: h * 0.04,
                      width: h * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: h * 0.02,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: h * 0.04,
                      width: h * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Obx(() => IconButton(
                              onPressed: () {
                                controller.toggleLike(context);
                              },
                              icon: Icon(
                                controller.likedImages.contains(
                                        images[controller.currentIndex.value])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: h * 0.02,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: h * 0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      h * 0.04,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await controller.downloadImage(context);
                          },
                          icon: Icon(
                            Icons.download,
                            color: Colors.black,
                            size: h * 0.03,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await controller.setWallpaper(context);
                          },
                          icon: Icon(
                            Icons.wallpaper_sharp,
                            color: Colors.black,
                            size: h * 0.03,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            controller.shareImage(context);
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.black,
                            size: h * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
