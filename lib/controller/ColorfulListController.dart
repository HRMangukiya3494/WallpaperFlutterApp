import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ColorfulListController extends GetxController {
  var wallpapers = <Map<String, dynamic>>[].obs;
  late int cid;
  late String color;

  ColorfulListController({required this.cid, required this.color});

  @override
  void onInit() {
    super.onInit();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers() async {
    try {
      var response = await http.get(Uri.parse(
          'https://customize.brainartit.com/wallpaper/webservices/color-wise-wallpaper.php?color_id=$cid&page=1'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['MaterialWallpaper'] is List) {
          wallpapers.assignAll(
            List<Map<String, dynamic>>.from(data['MaterialWallpaper']),
          );
        } else {
          print('Invalid data format: MaterialWallpaper is not a List');
        }
      } else {
        print('Failed to load wallpapers: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wallpapers: $e');
    }
  }
}
