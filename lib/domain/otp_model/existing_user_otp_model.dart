// class ExistingUserOtpModel {
//   String? responseCode;
//   bool? status;
//   String? token;
//   String? message;
//   UserDetails? userDetails;

//   ExistingUserOtpModel(
//       {this.responseCode,
//       this.status,
//       this.token,
//       this.message,
//       this.userDetails});

//   ExistingUserOtpModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     status = json['status'];
//     token = json['token'];
//     message = json['message'];
//     userDetails = json['user_details'] != null
//         ? new UserDetails.fromJson(json['user_details'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['status'] = this.status;
//     data['token'] = this.token;
//     data['message'] = this.message;
//     if (this.userDetails != null) {
//       data['user_details'] = this.userDetails!.toJson();
//     }
//     return data;
//   }
// }

// class UserDetails {
//   int? id;
//   String? fName;
//   String? lName;
//   String? email;
//   Null? image;
//   String? qId;
//   String? gender;
//   String? phone;

//   UserDetails(
//       {this.id,
//       this.fName,
//       this.lName,
//       this.email,
//       this.image,
//       this.qId,
//       this.gender,
//       this.phone});

//   UserDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fName = json['f_name'];
//     lName = json['l_name'];
//     email = json['email'];
//     image = json['image'];
//     qId = json['q_id'];
//     gender = json['gender'];
//     phone = json['phone'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['f_name'] = this.fName;
//     data['l_name'] = this.lName;
//     data['email'] = this.email;
//     data['image'] = this.image;
//     data['q_id'] = this.qId;
//     data['gender'] = this.gender;
//     data['phone'] = this.phone;
//     return data;
//   }
// }
class ExistingUserOtpModel {
  String? responseCode;
  bool? status;
  String? token;
  String? message;
  UserDetails? userDetails;

  ExistingUserOtpModel({
    this.responseCode,
    this.status,
    this.token,
    this.message,
    this.userDetails,
  });

  ExistingUserOtpModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code']?.toString(); // Handle null safely
    status = json['status'] ?? false; // Default to false if null
    token = json['token']?.toString(); // Convert to String safely
    message = json['message']?.toString(); // Handle null safely
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null; // Check null before parsing
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? image; // Update this from Null to String?
  String? qId;
  String? gender;
  String? phone;

  UserDetails({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.image,
    this.qId,
    this.gender,
    this.phone,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image']; // Can be null, handle as String?
    qId = json['q_id'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'image': image,
      'q_id': qId,
      'gender': gender,
      'phone': phone,
    };
  }
}
