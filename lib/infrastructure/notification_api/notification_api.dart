import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/notification_model/notification_model.dart';

Future<NotificationsModel?> notificationService() async {
  final url = Uri.parse('${baseUrl}/api/get-notification');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return NotificationsModel.fromJson(data);
    } else {
      print('Failed to load notifications: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching notifications: $e');
    return null;
  }
}
