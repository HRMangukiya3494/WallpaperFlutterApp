import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/CategoryController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';
import 'package:wallpaper/views/utils/ListUtils.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController _controller = Get.put(CategoryController());

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
                  CategoryName.length,
                      (index) => _buildCategoryButton(
                    categoryName: CategoryName[index],
                    isSelected: index == _controller.selectedIndex.value,
                    onTap: () => _controller.selectCategory(index),
                  ),
                ),
              )),
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: h * 0.02,
                crossAxisSpacing: h * 0.02,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          ImageUtils.ImagePath +
                              'HomeWallpaper${index + 1}.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                  );
                },
              ),
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

  Widget _buildCategoryContent() {
    int selectedIndex = _controller.selectedIndex.value;
    String selectedCategory = CategoryName[selectedIndex];

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      child: Text(
        "Selected Category: $selectedCategory",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
