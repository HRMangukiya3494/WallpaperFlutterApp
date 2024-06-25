import 'package:get/get.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';

List<Map> HomeStory = [
  {
    'Name': "Category",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeStory1,
    'onTap': () {
      Get.toNamed(AppRoutes.CATEGORY);
    },
  },
  {
    'Name': "Features",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeStory2,
    'onTap': () {
      Get.toNamed(AppRoutes.FEATURES);
    },
  },
  {
    'Name': "Colourful",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeStory3,
    'onTap': () {
      Get.toNamed(AppRoutes.COLORFUL);
    },
  },
  {
    'Name': "New",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeStory4,
    'onTap': () {
      Get.toNamed(AppRoutes.NEW);
    },
  },
  {
    'Name': "Trending",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeStory5,
    'onTap': () {
      Get.toNamed(AppRoutes.TRENDING);
    },
  },
];

List<Map> SearchCategory = [
  {
    'Name': "Wild Animal",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeWallpaper1,
  },
  {
    'Name': "Nature",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeWallpaper1,
  },
  {
    'Name': "City",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeWallpaper1,
  },
  {
    'Name': "Street",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeWallpaper1,
  },
  {
    'Name': "Wild Life",
    'ImagePath': ImageUtils.ImagePath + ImageUtils.HomeWallpaper1,
  },
];

List CategoryName = [
  "All",
  "Wild Animal",
  "Nature",
  "City",
  "Street",
  "Wild Life",
];
