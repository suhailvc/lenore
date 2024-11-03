class CheckOutModel {
  final String orderType;
  final String myName;
  final String myPhone;
  final String? gifteeName;
  final String? gifteePhone;
  final String to;
  final String message;
  final String date;
  final String makeAnonymous;
  final String? deliveryType;

  CheckOutModel({
    required this.orderType,
    required this.myName,
    required this.myPhone,
    this.gifteeName,
    this.gifteePhone,
    required this.to,
    required this.message,
    required this.date,
    required this.makeAnonymous,
    this.deliveryType,
  });

  // Convert CheckOutModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'order_type': orderType,
      'my_name': myName,
      'my_phone': myPhone,
      'giftee_name': gifteeName,
      'giftee_phone': gifteePhone,
      'to': to,
      'message': message,
      'date': date,
      'make_anonymous': makeAnonymous,
      'delivery_type': deliveryType,
    };
  }
}
