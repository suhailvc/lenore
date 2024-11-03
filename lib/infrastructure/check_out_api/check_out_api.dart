import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/check_out_model/check_out_model.dart';
import 'package:lenore/domain/check_out_model/svae_address_response.dart';

class CheckOutService {
  Future<SaveAddressResponse> saveAddress(
      CheckOutModel checkOutModel, String token) async {
    final url = Uri.parse(
        "${baseUrl}/api/save-address?order_type=${checkOutModel.orderType}&my_name=${checkOutModel.myName}&my_phone=${checkOutModel.myPhone}&giftee_name=${checkOutModel.gifteeName}&giftee_phone=${checkOutModel.gifteePhone}&to=${checkOutModel.to}&message=${checkOutModel.message}&date=${checkOutModel.date}&make_anonymous=${checkOutModel.makeAnonymous}&delivery_type=${checkOutModel.deliveryType}");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('sucess');
      return SaveAddressResponse.fromJson(json.decode(response.body));
    } else {
      print(token);
      print(checkOutModel.orderType);
      print(checkOutModel.myName);
      print(checkOutModel.myPhone);
      print(checkOutModel.makeAnonymous);
      print('error');
      throw Exception('Failed to save address');
    }
  }
}
