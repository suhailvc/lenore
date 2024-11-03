import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';
import 'dart:io';

Future<String> editProfileService({
  required String fName,
  required String email,
  required String gender,
  String? lName,
  File? image,
  required String token,
}) async {
  final url = Uri.parse("${baseUrl}/api/profile-update");

  try {
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      'Authorization': 'Bearer $token', // Add 'Bearer' before the token
    });

    // Add text fields
    request.fields['f_name'] = fName;
    request.fields['email'] = email;
    request.fields['gender'] = gender;
    if (lName != null) {
      request.fields['l_name'] = lName;
    }

    // Add the image file if it exists
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    } else {
      print("No image provided");
    }

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      print('Profile updated successfully');
      return 'Success';
    } else {
      print('Profile update failed with status: ${response.statusCode}');
      print('Token: $token');
      print('First Name: $fName');
      print('Email: $email');
      print('Gender: $gender');
      print('Last Name: ${lName ?? "N/A"}');
      if (image != null) {
        print('Image path: ${image.path}');
      }
      return 'failed';
    }
  } catch (e) {
    print('Error occurred: $e');
    return 'failed';
  }
}
// import 'package:http/http.dart' as http;
// import 'package:lenore/core/constant.dart';

// import 'dart:io';

// Future<String> editProfileService(
//     {required String fName,
//     required String email,
//     required String gender,
//     String? lName,
//     File? image,
//     required String token}) async {
//   final url = Uri.parse("${baseUrl}/api/profile-update");

//   try {
//     var request = http.MultipartRequest("POST", url);
//     request.headers.addAll({
//       'Authorization': 'Bearer $token', // Add 'Bearer' before the token
//     });
//     // Add text fields
//     request.fields['f_name'] = fName;

//     if (lName != null) {
//       request.fields['l_name'] = lName;
//     }
//     request.fields['email'] = email;
//     request.fields['gender'] = gender;
//     if (image != null) {
//       request.files.add(await http.MultipartFile.fromPath('image', image.path));
//     }

//     var response = await request.send();
//     //final responseData = await response.stream.bytesToString();
//     // final decodedResponse = json.decode(responseData);

//     if (response.statusCode == 200) {
//       return 'Success';
//     } else {
//       print(token);
//       print(fName);
//       print(email);
//       print(gender);
//       print(lName);
//       print(image);
//       print('200 failed');
//       return 'failed';
//     }
//   } catch (e) {
//     print('400');
//     print(token);
//     return "failed";
//   }
// }
