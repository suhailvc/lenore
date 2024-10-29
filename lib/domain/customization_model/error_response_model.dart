class CustomizationErrorResponse {
  final bool status;
  final Map<String, List<String>> errors;

  CustomizationErrorResponse({required this.status, required this.errors});

  factory CustomizationErrorResponse.fromJson(Map<String, dynamic> json) {
    return CustomizationErrorResponse(
      status: json['status'],
      errors: (json['errors'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }
}
