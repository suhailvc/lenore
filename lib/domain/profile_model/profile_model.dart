class ProfileModel {
  final bool status;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ProfileData {
  final int id;
  final String fName;
  final String? lName;
  final String email;
  final String qId;
  final String phone;
  final String gender;
  final String? image;

  ProfileData({
    required this.id,
    required this.fName,
    this.lName,
    required this.email,
    required this.qId,
    required this.phone,
    required this.gender,
    this.image,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? 0,
      fName: json['f_name'] ?? '',
      lName: json['l_name'],
      email: json['email'] ?? '',
      qId: json['q_id'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] is String
          ? json['image']
          : null, // Handle image as String or null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'q_id': qId,
      'phone': phone,
      'gender': gender,
      'image': image,
    };
  }
}


// class ProfileModel {
//   final bool status;
//   final String message;
//   final ProfileData data;

//   ProfileModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       status: json['status'],
//       message: json['message'],
//       data: ProfileData.fromJson(json['data']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data.toJson(),
//     };
//   }
// }

// class ProfileData {
//   final int id;
//   final String fName;
//   final String? lName;
//   final String email;
//   final String qId;
//   final String phone;
//   final String gender;
//   final String? image;

//   ProfileData({
//     required this.id,
//     required this.fName,
//     this.lName,
//     required this.email,
//     required this.qId,
//     required this.phone,
//     required this.gender,
//     this.image,
//   });

//   factory ProfileData.fromJson(Map<String, dynamic> json) {
//     return ProfileData(
//       id: json['id'],
//       fName: json['f_name'],
//       lName: json['l_name'],
//       email: json['email'],
//       qId: json['q_id'],
//       phone: json['phone'],
//       gender: json['gender'],
//       image: json['image'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'f_name': fName,
//       'l_name': lName,
//       'email': email,
//       'q_id': qId,
//       'phone': phone,
//       'gender': gender,
//       'image': image,
//     };
//   }
// }
