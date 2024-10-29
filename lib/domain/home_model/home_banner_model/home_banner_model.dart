class HomeBannerModel {
  bool? status;
  String? message;
  List<Data>? data;

  HomeBannerModel({this.status, this.message, this.data});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? titleOne;
  String? titleOnear;
  String? titleTwo;
  String? titleTwoar;
  String? image;
  int? link;

  Data(
      {this.id,
      this.titleOne,
      this.titleOnear,
      this.titleTwo,
      this.titleTwoar,
      this.image,
      this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleOne = json['title_one'];
    titleOnear = json['title_onear'];
    titleTwo = json['title_two'];
    titleTwoar = json['title_twoar'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_one'] = this.titleOne;
    data['title_onear'] = this.titleOnear;
    data['title_two'] = this.titleTwo;
    data['title_twoar'] = this.titleTwoar;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
