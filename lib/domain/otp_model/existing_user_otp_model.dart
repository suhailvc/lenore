class ExistingUserOtpModel {
  String? responseCode;
  bool? status;
  String? token;
  String? message;
  UserDetails? userDetails;

  ExistingUserOtpModel(
      {this.responseCode,
      this.status,
      this.token,
      this.message,
      this.userDetails});

  ExistingUserOtpModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    status = json['status'];
    token = json['token'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? fName;
  String? lName;
  String? email;
  Null? image;
  String? qId;
  String? gender;
  String? phone;

  UserDetails(
      {this.id,
      this.fName,
      this.lName,
      this.email,
      this.image,
      this.qId,
      this.gender,
      this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image'];
    qId = json['q_id'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['q_id'] = this.qId;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    return data;
  }
}
