import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://customize.brainartit.com/wallpaper/webservices/';

  Future<Map<String, dynamic>> fetchWallpapers(int page) async {
    final response = await http.get(Uri.parse('${baseUrl}latest.php?page=$page'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}
