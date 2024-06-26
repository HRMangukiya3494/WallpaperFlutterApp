import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  var wallpapers = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var response = await http.get(Uri.parse('https://customize.brainartit.com/wallpaper/webservices/category.php'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['MaterialWallpaper'] is List) {
          categories.assignAll(List<Map<String, dynamic>>.from(data['MaterialWallpaper']));
        } else {
          log('Invalid data format: MaterialWallpaper is not a List');
        }
      } else {
        log('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching categories: $e');
    }
  }

  Future<void> fetchWallpapers() async {
    if (!hasMore.value) return;
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse(
          'https://customize.brainartit.com/wallpaper/webservices/category-wise-wallpaper.php?cat_id=${categories[selectedIndex.value]['cid']}&page=$page'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['MaterialWallpaper'] is List) {
          var newWallpapers = List<Map<String, dynamic>>.from(data['MaterialWallpaper']);
          wallpapers.addAll(newWallpapers);
          hasMore.value = newWallpapers.isNotEmpty;
          page++;
        } else {
          log('Invalid data format: MaterialWallpaper is not a List');
          hasMore.value = false;
        }
      } else {
        log('Failed to load wallpapers: ${response.statusCode}');
        hasMore.value = false;
      }
    } catch (e) {
      log('Error fetching wallpapers: $e');
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    page = 1;
    hasMore.value = true;
    wallpapers.clear();
    fetchWallpapers();
  }
}
