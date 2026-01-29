import 'package:flutter/material.dart';
import '../../data/membership_tier.dart';
import 'membership_card_container.dart';

class MembershipCardBack extends StatelessWidget {
  final MembershipTierConfig config;

  const MembershipCardBack({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MembershipCardContainer(
      gradient: config.gradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BENEFITS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: config.textColor,
            ),
          ),
          const SizedBox(height: 12),
          ...config.benefits.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "• $b",
                style: TextStyle(
                  color: config.textColor.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
