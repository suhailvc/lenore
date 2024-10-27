import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/home_model/gift_by_event_model/gift_by_event_model.dart';

Future<GiftByEventModel?> giftByEventService() async {
  final url = Uri.parse('$baseUrl/api/get-event-categories');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final GiftByEventModel giftByEventList =
          GiftByEventModel.fromJson(responseData);
      return giftByEventList;
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
