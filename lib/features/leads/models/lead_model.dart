class LeadModel {
  final String id;

  final String type; // "Self" | "Referral"
  final String name;
  final String? referredBy;

  final String? status; // New, In_Process, Approved, Rejected, Disbursed
  final double? amount;
  final String? product;
  final int points;

  final String? contactPhone;
  final String? contactEmail;

  final DateTime? loginDate;
  final DateTime? statusDate;

  LeadModel({
    required this.id,
    required this.type,
    required this.name,
    this.referredBy,
    this.status,
    this.amount,
    this.product,
    required this.points,
    this.contactPhone,
    this.contactEmail,
    this.loginDate,
    this.statusDate,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return LeadModel(
      id: json["id"]?.toString() ?? "",

      type: json["type"]?.toString() ?? "Self",
      name: json["name"]?.toString() ?? "",
      referredBy: json["referredBy"]?.toString(),

      status: json["status"]?.toString(),
      amount: json["amount"] == null
          ? null
          : double.tryParse(json["amount"].toString()),
      product: json["product"]?.toString(),
      points: int.tryParse(json["points"]?.toString() ?? "0") ?? 0,

      contactPhone: json["contactPhone"]?.toString(),
      contactEmail: json["contactEmail"]?.toString(),

      loginDate: parseDate(json["loginDate"]),
      statusDate: parseDate(json["statusDate"]),
    );
  }
}
