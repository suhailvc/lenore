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
  String? video; // New field for video
  String? screen;
  String? screenId;
  String? screenName;

  Data({
    this.id,
    this.titleOne,
    this.titleOneAr,
    this.description,
    this.descriptionAr,
    this.image,
    this.video, // Include in constructor
    this.screen,
    this.screenId,
    this.screenName,
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
      video: json['video'], // Parse the video field
      screen: json['screen'],
      screenId: json['screen_id'],
      screenName: json['screen_name'],
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
      'video': video, // Include the video field
      'screen': screen,
      'screen_id': screenId,
      'screen_name': screenName,
    };
  }
}
// class Data {
//   int? id;
//   String? titleOne;
//   String? titleOneAr;
//   String? description;
//   String? descriptionAr;
//   String? image;
//   String? screen;
//   String? screenId;
//   String? screenName; // New field added

//   Data({
//     this.id,
//     this.titleOne,
//     this.titleOneAr,
//     this.description,
//     this.descriptionAr,
//     this.image,
//     this.screen,
//     this.screenId,
//     this.screenName, // Initialize the new field
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
//       screenName: json['screen_name'], // Parse the new field
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
//       'screen_name': screenName, // Include the new field
//     };
//   }
// }
