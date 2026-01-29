import 'package:flutter/material.dart';

class AppUserAvatar extends StatelessWidget {
  final String? profileImageUrl;
  final String? gender;
  final double radius;

  const AppUserAvatar({
    super.key,
    required this.profileImageUrl,
    required this.gender,
    this.radius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        profileImageUrl != null &&
        profileImageUrl!.trim().isNotEmpty &&
        profileImageUrl != "null";

    if (hasImage) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(profileImageUrl!),
        backgroundColor: Colors.grey.shade200,
      );
    }

    final assetPath = (gender == "Female")
        ? "assets/avatars/female.jpg"
        : "assets/avatars/male.jpg";

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: AssetImage(assetPath),
    );
  }
}
