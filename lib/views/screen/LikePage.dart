import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/LikesController.dart';
import 'package:wallpaper/views/screen/ImagePage.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class LikePage extends StatelessWidget {
  const LikePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final LikesController controller = Get.put(LikesController());
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Likes",
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
        child: Obx(
          () => controller.likedImages.isEmpty
              ? Center(
                  child: Text(
                    'No liked images yet.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: h * 0.02,
                  crossAxisSpacing: h * 0.02,
                  itemCount: controller.likedImages.length,
                  itemBuilder: (context, index) {
                    String imageUrl = controller.likedImages[index];
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => FullScreenImagePage(
                              images: controller.likedImages,
                              initialIndex: index,
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                          ),
                        ),
                        Positioned(
                          top: h * 0.02,
                          right: h * 0.02,
                          child: GestureDetector(
                            onTap: () {
                              controller.removeFromLiked(imageUrl);
                            },
                            child: Container(
                              height: h * 0.038,
                              width: h * 0.038,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
