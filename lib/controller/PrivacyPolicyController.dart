import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  static Future<String> fetchPrivacyPolicy() async {
    var request = await HttpClient().getUrl(Uri.parse('https://customize.brainartit.com/chatgpt/api/privacy-policy'));
    var response = await request.close();

    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (jsonResponse['status'] == 1) {
        return jsonResponse['data'];
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw HttpException(response.reasonPhrase);
    }
  }
}