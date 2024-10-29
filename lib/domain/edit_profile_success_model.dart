class EditProfileSuccessResponse {
  final bool status;
  final String message;

  EditProfileSuccessResponse({required this.status, required this.message});

  factory EditProfileSuccessResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileSuccessResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
