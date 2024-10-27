import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/home_model/gift_by_voucher_model/gift_by_voucher_model.dart';

Future<GiftByVoucherModel?> giftByVoucherService() async {
  final url = Uri.parse('$baseUrl/api/get-vouchers');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['response_code']);

      final GiftByVoucherModel giftByVoucherList =
          GiftByVoucherModel.fromJson(responseData);
      print('gggggiiiifffffff${giftByVoucherList.data}');
      return giftByVoucherList;
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
