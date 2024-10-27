import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/home_model/home_banner_model/home_banner_model.dart';

Future<HomeBannerModel?> HomeBannerService() async {
  final url = Uri.parse('$baseUrl/api/get-banners');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final HomeBannerModel homeBannerList =
          HomeBannerModel.fromJson(responseData);

      return homeBannerList;
    } else {
      print('eeeeeeeeerrrrrrrrrrr');
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
