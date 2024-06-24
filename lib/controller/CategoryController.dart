import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}
