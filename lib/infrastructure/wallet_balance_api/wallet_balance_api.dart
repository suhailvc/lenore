import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:provider/provider.dart';

// API method to get wallet balance
Future<double?> walletBalanceApi(BuildContext context) async {
  final url = Uri.parse('$baseUrl/api/wallet-balance');

  try {
    final response = await http.get(
      url,
      headers: {
        //  'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await Provider.of<AuthProvider>(context, listen: false).getToken()}', // Assuming you have a function to get the access token
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        // The data comes as a number, so we convert to double
        return responseData['data'].toDouble();
      } else {
        print('API returned error: ${responseData['message']}');
        return null;
      }
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
