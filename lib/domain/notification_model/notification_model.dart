class NotificationsModel {
  final bool status;
  final String message;
  final List<NotificationData>? data;

  NotificationsModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => NotificationData.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class NotificationData {
  final int? id;
  final String? title;
  final String? titleAr;
  final String? description;
  final String? descriptionAr;
  final String? image;

  NotificationData({
    this.id,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.image,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      titleAr: json['titlear'],
      description: json['description'],
      descriptionAr: json['descriptionar'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titlear': titleAr,
      'description': description,
      'descriptionar': descriptionAr,
      'image': image,
    };
  }
}
