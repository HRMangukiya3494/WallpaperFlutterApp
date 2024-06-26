import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/CategoryController.dart';
import 'package:wallpaper/views/screen/ImagePage.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController _controller = Get.find<CategoryController>();

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
          "Categories",
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
        child: Column(
          children: [
            // Category Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    children: List.generate(
                      _controller.categories.length,
                      (index) => _buildCategoryButton(
                        categoryName: _controller.categories[index]
                                ['category_name'] ??
                            '',
                        isSelected: index == _controller.selectedIndex.value,
                        onTap: () => _controller.selectCategory(index),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: Obx(() {
                if (_controller.wallpapers.isEmpty &&
                    _controller.isLoading.value) {
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
                        _controller.fetchWallpapers();
                      }
                      return false;
                    },
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: h * 0.02,
                      crossAxisSpacing: h * 0.02,
                      itemCount: _controller.wallpapers.length +
                          (_controller.hasMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _controller.wallpapers.length) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        var wallpaperInfo = _controller.wallpapers[index];
                        return GestureDetector(
                          onTap: () {
                            List<String> images = _controller.wallpapers
                                .map((wallpaper) =>
                                    "https://hdwalls.wallzapps.com/upload/${wallpaper['images']}")
                                .toList();
                            Get.to(
                              FullScreenImagePage(
                                images: images,
                                initialIndex: index,
                              ),
                            );
                          },
                          child: Container(
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
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton({
    required String categoryName,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    double h = MediaQuery.of(Get.context!).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.04,
        padding: EdgeInsets.symmetric(horizontal: h * 0.01),
        margin: EdgeInsets.only(right: h * 0.02),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: isSelected
              ? null
              : Border.all(
                  color: Colors.white,
                ),
          borderRadius: BorderRadius.circular(
            h * 0.01,
          ),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: h * 0.016,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
