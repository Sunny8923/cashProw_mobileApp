import 'package:flutter/material.dart';
import '../../data/membership_tier.dart';
import 'membership_card_container.dart';

class MembershipCardFront extends StatelessWidget {
  final MembershipTierConfig config;

  const MembershipCardFront({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MembershipCardContainer(
      gradient: config.gradient,
      child: Stack(
        children: [
          /// 🔹 Large blurred circle (top-left)
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          /// 🔹 Soft diagonal light streak
          Positioned(
            top: 40,
            right: -80,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 220,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ),

          /// 🔹 Small secondary blob (bottom-right)
          Positioned(
            bottom: -50,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.05),
              ),
            ),
          ),

          /// 🔹 Company logo watermark
          Positioned(
            top: 18,
            right: 18,
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(
                "assets/images/logo_white.png", // your white logo
                height: 28,
              ),
            ),
          ),

          /// 🔹 Tier emblem
          Positioned(
            top: 18,
            left: 18,
            child: Icon(
              _tierIcon(config.title),
              size: 30,
              color: config.textColor.withOpacity(
                config.title == "VIP" ? 1 : 0.9,
              ),
            ),
          ),

          /// 🔹 Company logo watermark (FINAL)
          Positioned(
            top: 18,
            right: 18,
            child: Opacity(
              opacity: 0.60, // subtle, premium
              child: Image.asset(
                "assets/images/logo_white.png",
                height: 45, // not too big
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// 🔹 Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Text(
                config.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: config.textColor,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "MEMBERSHIP CARD",
                style: TextStyle(
                  color: config.textColor.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 14),

              /// 🔹 Micro details row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Member since 2025",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: config.textColor.withOpacity(0.75),
                    ),
                  ),
                  Text(
                    "•••• 4281",
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                      color: config.textColor.withOpacity(0.85),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// 🔹 Bottom accent line
              Container(
                height: 3,
                width: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: config.textColor.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _tierIcon(String title) {
    switch (title) {
      case "GOLD":
        return Icons.workspace_premium_rounded; // 👑 vibe
      case "VIP":
        return Icons.diamond_rounded; // ◆
      default:
        return Icons.star_rounded; // ⭐
    }
  }
}
