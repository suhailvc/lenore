import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/voucher_detail_model/voucher_detail_model.dart';

Future<VoucherDetailModel?> vocherDetailApi(int id) async {
  final url = Uri.parse("$baseUrl/api/voucher-details?id=$id");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return VoucherDetailModel.fromJson(data);
    } else {
      print(
          "Failed to load voucher details. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error occurred: $e");
    return null;
  }
}
