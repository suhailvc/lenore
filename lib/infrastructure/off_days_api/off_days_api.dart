import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'dart:convert';

import 'package:lenore/domain/off_days_model/off_days_model.dart';

Future<OffDaysResponse> offDaysMethod() async {
  try {
    final response = await http.get(Uri.parse('${baseUrl}/api/get-off-days'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return OffDaysResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to load off days: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching off days: $e');
  }
}
