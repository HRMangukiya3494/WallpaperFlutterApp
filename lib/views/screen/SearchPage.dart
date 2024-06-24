import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/controller/SearchController.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';
import 'package:wallpaper/views/utils/ListUtils.dart';

class SearchPage extends StatelessWidget {
  final SearchCategoryController controller = Get.put(
    SearchCategoryController(),
  );

  final ValueNotifier<bool> isSearching = ValueNotifier(false);

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
                borderRadius: BorderRadius.circular(
                  h * 0.02,
                ),
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
                      onChanged: (value) {
                        isSearching.value = value.isNotEmpty;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: h * 0.06,
                      width: h * 0.06,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            ImageUtils.ImagePath + ImageUtils.BlackSearchArrow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isSearching,
              builder: (context, value, child) {
                if (value) {
                  return Expanded(
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
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: SearchCategory.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: h * 0.02),
                          height: h * 0.14,
                          width: w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              h * 0.02,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  SearchCategory[index]['ImagePath']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              SearchCategory[index]['Name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.028,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
