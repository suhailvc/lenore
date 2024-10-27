class UserRegistrationDataTakenModel {
  String? responseCode;
  bool? status;
  String? message;
  Errors? errors;

  UserRegistrationDataTakenModel(
      {this.responseCode, this.status, this.message, this.errors});

  UserRegistrationDataTakenModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;
  List<String>? qId;
  List<String>? phone;

  Errors({this.email, this.qId, this.phone});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    qId = json['q_id'].cast<String>();
    phone = json['phone'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['q_id'] = this.qId;
    data['phone'] = this.phone;
    return data;
  }
}
