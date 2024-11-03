import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/customization_model/error_response_model.dart';
import 'dart:io';

import 'package:lenore/domain/customization_model/success_model.dart';

Future<dynamic> submitRepairRequest({
  required String name,
  required String phone,
  required String type,
  required String weight,
  required String purity,
  required String productType,
  required String message,
  required String filterType,
  List<File>? images,
}) async {
  final url = Uri.parse("${baseUrl}/api/submit-customisation-request");

  try {
    var request = http.MultipartRequest("POST", url);

    // Add text fields
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['type'] = type;
    request.fields['weight'] = weight;
    request.fields['purity'] = purity;
    request.fields['product_type'] = productType;
    request.fields['filter_type'] = filterType;
    request.fields['message'] = message;

    // Add images if any
    if (images != null && images.isNotEmpty) {
      for (var image in images) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'images[]',
          stream,
          length,
          filename: image.path.split('/').last,
        );
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();
    final responseData = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      if (decodedResponse['status'] == true) {
        print('true');
        return CustomizationSuccessResponse.fromJson(decodedResponse);
      } else {
        print('false');
        return CustomizationErrorResponse.fromJson(decodedResponse);
      }
    } else {
      return CustomizationErrorResponse(
        status: false,
        errors: {
          'general': ['Request failed with status: ${response.statusCode}']
        },
      );
    }
  } catch (e) {
    return CustomizationErrorResponse(
      status: false,
      errors: {
        'general': ['Error occurred: $e']
      },
    );
  }
}
