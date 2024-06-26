import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/CategoryController.dart';
import 'package:wallpaper/controller/SearchController.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';

class SearchPage extends StatelessWidget {
  final SearchCategoryController controller = Get.put(
    SearchCategoryController(),
  );

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Wallpaper",
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
        padding: EdgeInsets.only(
          left: h * 0.02,
          bottom: h * 0.02,
          right: h * 0.02,
          top: h * 0.04,
        ),
        child: Column(
          children: [
            Container(
              height: h * 0.06,
              width: w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h * 0.02),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Search Category",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: h * 0.02),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: h * 0.06,
                      width: h * 0.06,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageUtils.ImagePath +
                              ImageUtils.BlackSearchArrow),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: Obx(() {
                final categories = controller.filteredCategories;
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        // Find the index of the selected category in the original list
                        int originalIndex = Get.find<CategoryController>()
                            .categories
                            .indexWhere(
                              (cat) => cat['cid'] == category['cid'],
                            );
                        // Navigate to category page with the correct index
                        controller.selectCategory(originalIndex);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        height: h * 0.14,
                        width: w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(h * 0.02),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://hdwalls.wallzapps.com/upload/category/" +
                                  category['category_image'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category['category_name'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: h * 0.028,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
