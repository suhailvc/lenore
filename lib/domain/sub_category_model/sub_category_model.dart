class SubCategoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  SubCategoryModel({this.status, this.message, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Null? namear;
  String? image;
  int? categoryId;
  String? categoryName;
  String? categoryNamear;

  Data(
      {this.id,
      this.name,
      this.namear,
      this.image,
      this.categoryId,
      this.categoryName,
      this.categoryNamear});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namear = json['namear'];
    image = json['image'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNamear = json['category_namear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['namear'] = this.namear;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_namear'] = this.categoryNamear;
    return data;
  }
}
