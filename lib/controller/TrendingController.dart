import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrendingController extends GetxController {
  var wallpapers = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchWallpapers();
    super.onInit();
  }

  Future<void> fetchWallpapers() async {
    try {
      isLoading(true);
      for (int page = 1; page <= 10; page++) {
        var response = await http.get(Uri.parse('https://customize.brainartit.com/wallpaper/webservices/popular.php?page=$page'));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          var fetchedWallpapers = data['MaterialWallpaper'].map<String>((item) => 'https://hdwalls.wallzapps.com/upload/custom/${item['image']}').toList();
          wallpapers.addAll(fetchedWallpapers);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
