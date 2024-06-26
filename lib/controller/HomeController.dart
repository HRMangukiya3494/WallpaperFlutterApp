import 'package:get/get.dart';
import 'package:wallpaper/views/utils/ApiService.dart';

class HomeController extends GetxController {
  var wallpapers = [].obs;
  var isLoading = false.obs;
  var page = 1;
  var displayedCids = Set<int>();

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
        List<dynamic> materialWallpapers = response['MaterialWallpaper'];
        materialWallpapers.forEach((wallpaper) {
          // Ensure 'cid' is parsed as an integer
          int cid = int.tryParse(wallpaper['cid'].toString()) ?? 0;
          if (cid != 0 && !displayedCids.contains(cid)) {
            wallpapers.add(wallpaper);
            displayedCids.add(cid);
          }
        });
        page++;
      }
    } finally {
      isLoading.value = false;
    }
  }

}
