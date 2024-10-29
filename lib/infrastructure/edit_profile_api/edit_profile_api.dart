import 'package:http/http.dart' as http;
import 'package:lenore/core/constant.dart';

import 'dart:io';

Future<String> editProfileService({
  required String fName,
  required String email,
  required String gender,
  String? lName,
  File? image,
}) async {
  final url = Uri.parse("${baseUrl}/api/profile-update");

  try {
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWMzYmQxNmM1M2RiZTczZjU0ZTMwN2JlM2VhOWY0MmVjMjVmYWY3YjJmNTM1ZDFmNjA2Y2QxYTkzZGU4ZDViZTk2MzNiMjU3NjkwZTA0NTgiLCJpYXQiOjE3MzAxMTc3NTIuODE5ODM4LCJuYmYiOjE3MzAxMTc3NTIuODE5ODM5LCJleHAiOjE3NjE2NTM3NTIuODE3OTM1LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.l7fSzgKjbtP_CyqfcVJo5LV7iV5dN_WtLVjfZyMPcf9qFXQrGv3wtRmJ63b02UkxsV8zexEXBrwhmL6bu4aCpBcKM6RFHld2AInk3ulrjESyuc5IVbiG7d6Alr36VRJeOuC2BUG_jAMi2KKYmzq5HV2oDqBMMEXTQ5eDKKA31T2RwQyDJM65dbm0nRbNOrBdymv179r9d1U7BbmfBd7KfxbRODfIqE8cGS0adeXPCn9QdekTxDk2WdzTTW31XbusnFmkvMlA8km1YJg53-NLHGrGvAxaPC9DQwtBAlrFriXtpBPOZ89JLtGoAMKV-n8WwntiOCnVL6K09y82RC1ysqUA_6qnk3FpPlHOchEoBWFAddQJ2m7COjVT5ozbf_j6f0qP0TSCgDzrfNKD46VIoe70UBs2koHRSs-aa95SukJazaYwL7du2LIGEikv35x3fvHeh450j3BdbBOSiC0J2V1G5NEtPY8Pa0DqX4dXCMHCcbq4GABxFM8vdGlCn_6Ke1SgsW5Rq4yhJrIfqEi8mbGQEboWi4yeONzVj5wH-ZTUVbSGjm1mvr_-uf9In01gARYlMOKgJ8tohiAmU6m-GC0xekWhN9nEeTXx4OLhv23JJT7odf1sYQxkWCey6Q5kdqztmg7wmWeqSsUv4aGJ7XowrXHFYxD0Zyd-S0ftUlA',
      'Content-Type': 'multipart/form-data', // Ensures multipart content type
    });
    // Add text fields
    request.fields['f_name'] = fName;

    if (lName != null) {
      request.fields['l_name'] = lName;
    }
    request.fields['email'] = email;
    request.fields['gender'] = gender;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    var response = await request.send();
    //final responseData = await response.stream.bytesToString();
    // final decodedResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return 'failed';
    }
  } catch (e) {
    return "failed";
  }
}
