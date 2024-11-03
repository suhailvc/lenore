import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

class couponApiService {
  Future<Map<String, dynamic>?> getCouponDiscount(String couponCode) async {
    final url =
        Uri.parse('${baseUrl}/api/get-coupon-discount?coupon_code=$couponCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        return data['data'];
      }
    }
    return null;
  }
}
