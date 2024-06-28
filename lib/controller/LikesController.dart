import 'package:get/get.dart';
import 'package:wallpaper/controller/DatabaseHelper.dart';

class LikesController extends GetxController {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<String> likedImages = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    fetchLikedImages();
  }

  Future<void> fetchLikedImages() async {
    likedImages.assignAll(await databaseHelper.getLikedImages());
  }

  Future<void> addToLiked(String imageUrl) async {
    await databaseHelper.insert(imageUrl);
    fetchLikedImages();
  }

  Future<void> removeFromLiked(String imageUrl) async {
    await databaseHelper.delete(imageUrl);
    fetchLikedImages();
  }

  bool isLiked(String imageUrl) {
    return likedImages.contains(imageUrl);
  }
}
