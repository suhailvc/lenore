import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/gold_purity_model/gold_purity_model.dart';

class GoldpurityApi {
  static Future<GoldPurityModel?> fetchGoldPurity() async {
    String url = '$baseUrl/api/get-gold';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GoldPurityModel.fromJson(data);
      } else {
        print(
            "Failed to fetch gold purity data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error occurred: $error");
      return null;
    }
  }
}
