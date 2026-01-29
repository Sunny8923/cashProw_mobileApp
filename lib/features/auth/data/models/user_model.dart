class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? phone;
  final String? address;
  final String? product;
  final String? card;
  final int points;
  final String? gender;
  final String? profileImageUrl;
  final String? occupation;
  final double? salary; // ✅ added

  final DateTime? dob;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.address,
    this.product,
    this.card,
    required this.points,
    this.profileImageUrl,
    this.occupation,
    this.salary,
    this.dob,
    this.createdAt,
    this.updatedAt,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return UserModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString(),
      email: json["email"]?.toString() ?? "",
      phone: json["phone"]?.toString(),
      address: json["address"]?.toString(),
      product: json["product"]?.toString(),
      card: json["card"]?.toString(),
      points: int.tryParse(json["points"]?.toString() ?? "0") ?? 0,

      profileImageUrl: json["profileImageUrl"]?.toString(), // ✅ added
      gender: json["gender"]?.toString(),
      occupation: json["occupation"]?.toString(), // ✅ added
      salary: (json["salary"] as num?)?.toDouble(),

      // ✅ added
      dob: parseDate(json["dob"]),
      createdAt: parseDate(json["createdAt"]),
      updatedAt: parseDate(json["updatedAt"]),
    );
  }
}
