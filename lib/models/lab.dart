class Lab {
  final int id;
  final String name;
  final String registrationNumber;
  final String telephoneNumber;
  final String email;
  final String address;
  final String? website;
  final String? about;
  final String? certificate;
  final DateTime createdAt;
  final DateTime updatedAt;

  static DateTime parseDateTime(String? dateStr) {
    return dateStr != null ? DateTime.parse(dateStr) : DateTime.now();
  }

  Lab({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.telephoneNumber,
    required this.email,
    required this.address,
    this.website,
    this.about,
    this.certificate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    try {
      return Lab(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        registrationNumber: json['registrationNumber'] ?? '',
        telephoneNumber: json['telephoneNumber'] ?? '',
        email: json['email'] ?? '',
        address: json['address'] ?? '',
        website: json['website'],
        about: json['about'],
        certificate: json['certificate'],
        createdAt: parseDateTime(json['createdAt']),
        updatedAt: parseDateTime(json['updatedAt']),
      );
    } catch (e) {
      print('Error parsing lab data: $e\nJSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'registrationNumber': registrationNumber,
    'telephoneNumber': telephoneNumber,
    'email': email,
    'address': address,
    'website': website,
    'about': about,
    'certificate': certificate,
  };
}
