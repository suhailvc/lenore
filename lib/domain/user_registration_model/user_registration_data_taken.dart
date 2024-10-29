class UserRegistrationDataTakenModel {
  final String responseCode;
  final bool status;
  final String message;
  final ErrorDetails? errors;

  UserRegistrationDataTakenModel({
    required this.responseCode,
    required this.status,
    required this.message,
    this.errors,
  });

  factory UserRegistrationDataTakenModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationDataTakenModel(
      responseCode: json['response_code'],
      status: json['status'],
      message: json['message'],
      errors:
          json['errors'] != null ? ErrorDetails.fromJson(json['errors']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response_code': responseCode,
      'status': status,
      'message': message,
      'errors': errors?.toJson(),
    };
  }
}

class ErrorDetails {
  final List<String>? email;
  final List<String>? qId;
  final List<String>? phone;

  ErrorDetails({
    this.email,
    this.qId,
    this.phone,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) {
    return ErrorDetails(
      email: json['email'] != null ? List<String>.from(json['email']) : null,
      qId: json['q_id'] != null ? List<String>.from(json['q_id']) : null,
      phone: json['phone'] != null ? List<String>.from(json['phone']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'q_id': qId,
      'phone': phone,
    };
  }
}
