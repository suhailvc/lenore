class ProductListModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? currentPage;
  int? lastPage;
  String? perPage;
  int? total;

  ProductListModel(
      {this.status,
      this.message,
      this.data,
      this.currentPage,
      this.lastPage,
      this.perPage,
      this.total});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? namear;
  String? thumbImage;
  int? price;

  Data({this.id, this.name, this.namear, this.thumbImage, this.price});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namear = json['namear'];
    thumbImage = json['thumb_image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['namear'] = this.namear;
    data['thumb_image'] = this.thumbImage;
    data['price'] = this.price;
    return data;
  }
}
