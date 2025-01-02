class HomeBannerModel {
  bool? status;
  String? message;
  List<Data>? data;

  HomeBannerModel({this.status, this.message, this.data});

  // Factory constructor to create an instance from JSON
  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Data.fromJson(item))
          .toList(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Data {
  int? id;
  String? titleOne;
  String? titleOneAr;
  String? description;
  String? descriptionAr;
  String? image;
  String? screen;
  String? screenId;
  String? screenName; // New field added

  Data({
    this.id,
    this.titleOne,
    this.titleOneAr,
    this.description,
    this.descriptionAr,
    this.image,
    this.screen,
    this.screenId,
    this.screenName, // Initialize the new field
  });

  // Factory constructor to create an instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      titleOne: json['title_one'],
      titleOneAr: json['title_onear'],
      description: json['description'],
      descriptionAr: json['descriptionar'],
      image: json['image'],
      screen: json['screen'],
      screenId: json['screen_id'],
      screenName: json['screen_name'], // Parse the new field
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_one': titleOne,
      'title_onear': titleOneAr,
      'description': description,
      'descriptionar': descriptionAr,
      'image': image,
      'screen': screen,
      'screen_id': screenId,
      'screen_name': screenName, // Include the new field
    };
  }
}
// class HomeBannerModel {
//   bool? status;
//   String? message;
//   List<Data>? data;

//   HomeBannerModel({this.status, this.message, this.data});

//   // Factory constructor to create an instance from JSON
//   factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
//     return HomeBannerModel(
//       status: json['status'],
//       message: json['message'],
//       data: (json['data'] as List<dynamic>?)
//           ?.map((item) => Data.fromJson(item))
//           .toList(),
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class Data {
//   int? id;
//   String? titleOne;
//   String? titleOneAr;
//   String? description;
//   String? descriptionAr;
//   String? image;
//   String? screen;
//   String? screenId;

//   Data({
//     this.id,
//     this.titleOne,
//     this.titleOneAr,
//     this.description,
//     this.descriptionAr,
//     this.image,
//     this.screen,
//     this.screenId,
//   });

//   // Factory constructor to create an instance from JSON
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       id: json['id'],
//       titleOne: json['title_one'],
//       titleOneAr: json['title_onear'],
//       description: json['description'],
//       descriptionAr: json['descriptionar'],
//       image: json['image'],
//       screen: json['screen'],
//       screenId: json['screen_id'],
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title_one': titleOne,
//       'title_onear': titleOneAr,
//       'description': description,
//       'descriptionar': descriptionAr,
//       'image': image,
//       'screen': screen,
//       'screen_id': screenId,
//     };
//   }
// }
// class HomeBannerModel {
//   bool? status;
//   String? message;
//   List<Data>? data;

//   HomeBannerModel({this.status, this.message, this.data});

//   HomeBannerModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? titleOne;
//   String? titleOnear;
//   String? titleTwo;
//   String? titleTwoar;
//   String? image;
//   int? link;
//   String? description;
//   String? descriptionar;

//   Data({
//     this.id,
//     this.titleOne,
//     this.titleOnear,
//     this.titleTwo,
//     this.titleTwoar,
//     this.image,
//     this.link,
//     this.description,
//     this.descriptionar,
//   });

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     titleOne = json['title_one'];
//     titleOnear = json['title_onear'];
//     titleTwo = json['title_two'];
//     titleTwoar = json['title_twoar'];
//     image = json['image'];
//     link = json['link'];
//     description = json['description'];
//     descriptionar = json['descriptionar'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title_one'] = this.titleOne;
//     data['title_onear'] = this.titleOnear;
//     data['title_two'] = this.titleTwo;
//     data['title_twoar'] = this.titleTwoar;
//     data['image'] = this.image;
//     data['link'] = this.link;
//     data['description'] = this.description;
//     data['descriptionar'] = this.descriptionar;
//     return data;
//   }
// }
