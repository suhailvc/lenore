class SaveAddressResponse {
  final bool status;
  final String message;
  final int? addressId;

  SaveAddressResponse({
    required this.status,
    required this.message,
    this.addressId,
  });

  // Factory constructor to create an instance from JSON
  factory SaveAddressResponse.fromJson(Map<String, dynamic> json) {
    return SaveAddressResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      addressId: json['address_id'],
    );
  }
}
