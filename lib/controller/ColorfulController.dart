import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ColorfulController extends GetxController {
  var colors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchColors();
    super.onInit();
  }

  Future<void> fetchColors() async {
    try {
      var response = await http.get(Uri.parse('https://customize.brainartit.com/wallpaper/webservices/color.php'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        colors.assignAll(data['MaterialWallpaper']
            .where((item) => item['category_image'] != null)
            .map<Map<String, dynamic>>((item) => {
          'color': item['category_name'],
          'image': 'https://hdwalls.wallzapps.com/upload/color/${item['category_image']}',
          'cid': int.parse(item['cid']),
        })
            .toList());
      } else {
        log('Failed to load colors: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching colors: $e');
    }
  }
}
