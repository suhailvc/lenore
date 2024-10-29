class CustomizationSuccessResponse {
  final bool status;
  final String message;

  CustomizationSuccessResponse({required this.status, required this.message});

  factory CustomizationSuccessResponse.fromJson(Map<String, dynamic> json) {
    return CustomizationSuccessResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
