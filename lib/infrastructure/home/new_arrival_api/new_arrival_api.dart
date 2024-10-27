import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/home_model/new_arrival_model/new_arrival_model.dart';

Future<NewArrivalModel?> newArrivalService() async {
  final url = Uri.parse('$baseUrl/api/new-arrivals');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final NewArrivalModel newArrivalList =
          NewArrivalModel.fromJson(responseData);
      return newArrivalList;
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
