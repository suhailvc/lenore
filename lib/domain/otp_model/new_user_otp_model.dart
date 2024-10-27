class NewUserOtpModel {
  String? responseCode;
  bool? status;
  String? message;

  NewUserOtpModel({this.responseCode, this.status, this.message});

  NewUserOtpModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
