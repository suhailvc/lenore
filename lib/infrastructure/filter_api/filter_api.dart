import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/filter_model/filter_model.dart';
import 'package:lenore/domain/product_listing_model/product_listing_model.dart';

Future<ProductListModel> filterApiService({
  String? categoryId,
  List<int>? subcategoryId,
  List<int>? eventId,
  List<int>? collectionId,
  List<int>? gold,
  // required String token,
}) async {
  print("-------------gold---------$gold");
  print("--------------categoryid--------$categoryId");
  print("--------------subcategoryid--------$subcategoryId");
  print("--------------evenrid--------$eventId");
  print("--------------collectionid--------$collectionId");
  var url = Uri.parse('$baseUrl/api/filter-product');

  try {
    var request = http.MultipartRequest('POST', url);
    // request.headers['Authorization'] = 'Bearer $token';
    // request.headers['Content-Type'] = 'multipart/form-data';

    //Only add non-null and non-empty fields
    if (categoryId != null && categoryId.isNotEmpty) {
      request.fields['category_id'] = categoryId;
    }
    // request.fields['per_page'] = 10000.toString();
    request.fields['page'] = 1.toString();
    if (gold != null && gold.isNotEmpty) {
      request.fields['gold'] = json.encode(gold);
    }
    if (subcategoryId != null && subcategoryId.isNotEmpty) {
      request.fields['subcategory_id'] = json.encode(subcategoryId);
    }
    if (eventId != null && eventId.isNotEmpty) {
      request.fields['event_id'] = json.encode(eventId);
    }
    if (collectionId != null && collectionId.isNotEmpty) {
      request.fields['collection_id'] = json.encode(collectionId);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var filterModel = ProductListModel.fromJson(json.decode(response.body));
      print('Success');
      print(filterModel.data);
      return filterModel;
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      print("Response body: ${response.body}");
      throw Exception(
          'Failed to load filter data. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('exception');
    print("Exception caught: $e");
    throw Exception("An error occurred: $e");
  }
}

// Future<FilterModel> filterApiService({
//   String? categoryId,
//   List<int>? subcategoryId,
//   List<int>? eventId,
//   List<int>? collectionId,
//   List<int>? gold,
//   required String token,
// }) async {
//   print("-------------gold---------$gold");
//   print("--------------categoryid--------$categoryId");
//   print("--------------subcategoryid--------$subcategoryId");
//   print("--------------evenrid--------$eventId");
//   print("--------------collectionid--------$collectionId");
//   var url = Uri.parse('$baseUrl/api/filter-product');

//   var body = json.encode({
//     'category_id': categoryId,
//     'subcategory_id': subcategoryId,
//     'event_id': eventId,
//     'collection_id': collectionId,
//     'gold': gold,
//   });

//   var response = await http.post(url, body: body);

//   if (response.statusCode == 200) {
//     var filterModel = FilterModel.fromJson(json.decode(response.body));
//     print("----------${filterModel.data}");
//     return filterModel;
//   } else {
//     throw Exception('Failed to load filter data');
//   }
// }
// Future<FilterModel> filterApiService({
//   String? categoryId,
//   List<int>? subcategoryId,
//   List<int>? eventId,
//   List<int>? collectionId,
//   List<int>? gold,
//   required String token,
// }) async {
//   print("-------------gold---------$gold");
//   print("--------------categoryid--------$categoryId");
//   print("--------------subcategoryid--------$subcategoryId");
//   print("--------------evenrid--------$eventId");
//   print("--------------collectionid--------$collectionId");

  // var url = Uri.parse('$baseUrl/api/filter-product');
  // var request = http.MultipartRequest('POST', url);

  // request.headers['Authorization'] = 'Bearer $token';

  // // Pass `category_id` as a single field
  // if (categoryId != null) {
  //   request.fields['category_id'] = categoryId.toString();
  //   print("Category ID: ${categoryId.toString()}");
  // }

  // // Add each item in the lists as individual entries to mimic a list
  // if (subcategoryId != null) {
  //   for (var id in subcategoryId) {
  //     print("single id ${id.toString()}");
  //     request.fields['subcategory_id[]'] = id.toString();
  //   }
  //   print("Subcategory IDs: $subcategoryId");
  // }

  // if (eventId != null) {
  //   for (var id in eventId) {
  //     request.fields['event_id[]'] = id.toString();
  //   }
  //   print("Event IDs: $eventId");
  // }

  // if (collectionId != null) {
  //   for (var id in collectionId) {
  //     request.fields['collection_id[]'] = id.toString();
  //   }
  //   print("Collection IDs: $collectionId");
  // }

  // if (gold != null) {
  //   for (var id in gold) {
  //     request.fields['gold[]'] = id.toString();
  //   }
  //   print("Gold IDs: $gold");
  // }

  // var response = await request.send();
  // var responseData = await http.Response.fromStream(response);

  // // Log the entire response body for debugging
  // print("Response Body: ${responseData.body}");

  // if (responseData.statusCode == 200) {
  //   print('=----------------------filter success');
  //   var filterModel = FilterModel.fromJson(json.decode(responseData.body));
  //   print(filterModel.data); // Debug print for filterModel data
  //   return filterModel;
  // } else {
  //   throw Exception('Failed to load filter data');
  // }
//}




// class FilterApiService {
//   Future<FilterModel> filterApiService({
//     String? categoryId,
//     List<int>? subcategoryId,
//     List<int>? eventId,
//     List<int>? collectionId,
//     List<int>? gold,
//     required String token,
//   }) async {
//     print("-------------gold---------$gold");
//     print("--------------categoryid--------$categoryId");
//     print("--------------subcategoryid--------$subcategoryId");
//     print("--------------eventid--------$eventId");
//     print("--------------collectionid--------$collectionId");

//     final Uri url = Uri.parse("$baseUrl/api/filter-product");

//     // Prepare the multipart request
//     final request = http.MultipartRequest('POST', url);

//     // Add form data with optional fields
//     // request.fields["category_id"] = 3.toString();
//     if (categoryId != null) request.fields["category_id"] = categoryId;

//     if (subcategoryId != null)
//       request.fields["subcategory_id"] = jsonEncode(subcategoryId);
//     if (eventId != null) request.fields["event_id"] = json.encode(eventId);
//     if (collectionId != null)
//       request.fields["collection_id"] = json.encode(collectionId);
//     if (gold != null) request.fields["gold"] = json.encode(gold);

//     // Add the authorization token header
//     // request.headers['Authorization'] = 'Bearer $token';

//     print("--------------------------------------${request.fields}");

//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('=----------------------filter success');
//         print(FilterModel.fromJson(json.decode(response.body)).data);
//         return FilterModel.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to load filtered products');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
// class FilterApiService {
//   //final String _baseUrl = "https://lenore.qa/api";

//   Future<FilterModel> filterApiService({
//     String? categoryId,
//     List<int>? subcategoryId,
//     List<int>? eventId,
//     List<int>? collectionId,
//     List<int>? gold,
//     required String token,
//   }) async {
//     print("-------------gold---------$gold");
//     print("--------------categoryid--------$categoryId");
//     print("--------------subcategoryid--------$subcategoryId");
//     print("--------------evenrid--------$eventId");
//     print("--------------collectionid--------$collectionId");
//     final Uri url = Uri.parse("$baseUrl/api/filter-product");

//     // Prepare the form data with optional fields
//     final Map<String, String> formData = {};
//     if (categoryId != null) formData["category_id"] = categoryId;
//     if (subcategoryId != null)
//       formData["subcategory_id"] = json.encode(subcategoryId);
//     if (eventId != null) formData["event_id"] = json.encode(eventId);
//     if (collectionId != null)
//       formData["collection_id"] = json.encode(collectionId);
//     if (gold != null) formData["gold"] = json.encode(gold);
//     print("--------------------------------------$formData");
//     try {
//       final response = await http.post(
//         url,
//         body: formData,
//       );

//       if (response.statusCode == 200) {
//         print('=----------------------filter success');
//         print(FilterModel.fromJson(json.decode(response.body)).data);
//         return FilterModel.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to load filtered products');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
