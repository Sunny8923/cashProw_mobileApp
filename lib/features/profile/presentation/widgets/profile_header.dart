import 'package:cash_prow/core/widgets/app_back_button.dart';
import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileHeader extends StatelessWidget {
  final dynamic user;
  final double completion;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.completion,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 420,
      width: double.infinity,
      child: Stack(
        children: [
          /// 🎨 BACKGROUND WITH ROUND BOTTOM
          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                _bubble(-50, -20, 130), // left partially out
                _bubble(220, -40, 120), // top partially out
                _bubble(40, 170, 60), // center soft
                _bubble(300, 100, 170), // right partially out
              ],
            ),
          ),

          /// 🔙 BACK BUTTON
          Positioned(top: 36, left: 16, child: const AppBackButton()),

          /// 📛 USERNAME AT TOP
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Hi, ${user?.name ?? "User"} 👋",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          /// 👤 AVATAR CENTER
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Center(
              child: CircularPercentIndicator(
                radius: 48,
                lineWidth: 8,
                percent: (completion / 100).clamp(0, 1),
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white24,
                linearGradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFB7A5),
                    Color(0xFFF4A08A),
                    Color(0xFFE07A73),
                  ],
                ),
                center: AppUserAvatar(
                  profileImageUrl: user?.profileImageUrl,
                  gender: user?.gender,
                  radius: 40,
                ),
              ),
            ),
          ),

          /// 📊 % BELOW AVATAR
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  "${completion.toInt()}% Complete",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.12);
  }

  Widget _bubble(double left, double top, double size) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
