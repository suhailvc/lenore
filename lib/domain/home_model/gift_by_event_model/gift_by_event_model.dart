class GiftByEventModel {
  bool? status;
  String? message;
  List<Data>? data;

  GiftByEventModel({this.status, this.message, this.data});

  GiftByEventModel.fromJson(Map<String, dynamic> json) {
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
  String? eventCategory;
  String? eventCategoryar;
  String? image;

  Data({this.id, this.eventCategory, this.eventCategoryar, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventCategory = json['event_category'];
    eventCategoryar = json['event_categoryar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_category'] = this.eventCategory;
    data['event_categoryar'] = this.eventCategoryar;
    data['image'] = this.image;
    return data;
  }
}
