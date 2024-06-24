import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCategoryController extends GetxController {
  TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
