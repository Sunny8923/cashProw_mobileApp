import 'package:flutter/material.dart';

enum MembershipTier { silver, gold, vip }

class MembershipTierConfig {
  final String title;
  final List<String> benefits;
  final Gradient gradient;
  final Color textColor;

  const MembershipTierConfig({
    required this.title,
    required this.benefits,
    required this.gradient,
    required this.textColor,
  });
}

final membershipConfigs = {
  MembershipTier.silver: MembershipTierConfig(
    title: "SILVER",
    benefits: [
      "Basic rewards access",
      "Standard support",
      "Limited gift cards",
    ],
    gradient: const LinearGradient(
      colors: [Color(0xFFE5E7EB), Color(0xFF9CA3AF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    textColor: const Color(0xFF374151),
  ),

  MembershipTier.gold: MembershipTierConfig(
    title: "GOLD",
    benefits: [
      "Higher reward rate",
      "Priority support",
      "Exclusive gift cards",
    ],
    gradient: const LinearGradient(
      colors: [Color(0xFFFFD54F), Color(0xFFFFA000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    textColor: const Color(0xFF5C3A00),
  ),

  MembershipTier.vip: MembershipTierConfig(
    title: "VIP",
    benefits: ["Maximum rewards", "Dedicated manager", "Early access offers"],
    gradient: const LinearGradient(
      colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    textColor: Colors.white,
  ),
};
