import 'package:get/get.dart';
import 'package:wallpaper/views/utils/ApiService.dart';

class NewController extends GetxController {
  var wallpapers = [].obs;
  var isLoading = false.obs;
  var page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchWallpapers();
  }

  void fetchWallpapers() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      var response = await ApiService().fetchWallpapers(page);
      if (response['MaterialWallpaper'] != null) {
        wallpapers.addAll(response['MaterialWallpaper']);
        page++;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
