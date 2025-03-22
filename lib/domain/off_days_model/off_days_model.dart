class OffDaysResponse {
  final bool status;
  final String message;
  final List<DateTime> data;

  OffDaysResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OffDaysResponse.fromJson(Map<String, dynamic> json) {
    return OffDaysResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((dateString) => DateTime.parse(dateString))
          .toList(),
    );
  }
}
