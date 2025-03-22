class CountryModel {
  final int id;
  final String name;
  final String iso2;
  final String iso3;
  final String phoneCode;
  final String region;
  final int status;

  CountryModel({
    required this.id,
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.phoneCode,
    required this.region,
    required this.status,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      iso2: json['iso2'],
      phoneCode: json['phone_code'],
      iso3: json['iso3'],
      region: json['region'],
      status: json['status'],
    );
  }
}
