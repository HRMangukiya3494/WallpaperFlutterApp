import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/CategoryController.dart';

class SearchCategoryController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var filteredCategories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCategories.assignAll(Get.find<CategoryController>().categories);
    searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    var query = searchController.text.toLowerCase();
    var categories = Get.find<CategoryController>().categories;
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(
        categories.where((category) => category['category_name'].toLowerCase().contains(query)),
      );
    }
  }

  void selectCategory(int index) {
    var categoryController = Get.find<CategoryController>();
    categoryController.selectCategory(index);
    Get.toNamed('/category');
  }

  @override
  void onClose() {
    searchController.removeListener(_filterCategories);
    searchController.dispose();
    super.onClose();
  }
}
