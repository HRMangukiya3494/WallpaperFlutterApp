import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImagePage({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              // Full height of the screen
              aspectRatio: 1.0,
              // Ensure square aspect ratio (optional)
              initialPage: initialIndex,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              // Occupy full width
              scrollPhysics:
                  BouncingScrollPhysics(), // Optional: Add bounce effect
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
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
