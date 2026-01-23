import 'package:flutter/material.dart';
import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadCardAvatar extends ConsumerWidget {
  const LeadCardAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;

    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        // ✅ Brand gradient (no tertiary)
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.22),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: AppUserAvatar(
          radius: 21,
          profileImageUrl: user?.profileImageUrl,
          gender: user?.gender,
        ),
      ),
    );
  }
}

/// ✅ Status pill with dot indicator
class LeadCardStatusPillDot extends StatelessWidget {
  final String status;

  const LeadCardStatusPillDot({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();

    final isGreen = s == 'disbursed' || s == 'approved';
    final isWarning = s == 'pending' || s == 'in progress' || s == 'new';

    final fg = isGreen
        ? AppColors.success
        : (isWarning ? AppColors.warning : AppColors.primary);

    final bg = fg.withOpacity(0.12);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.22), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(shape: BoxShape.circle, color: fg),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              color: fg,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ Outlined type pill
class LeadCardTypePillOutlined extends StatelessWidget {
  final String type;

  const LeadCardTypePillOutlined({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isSelf = type.toLowerCase() == "self";

    // ✅ Self = primary, Referral = darker primary (no purple)
    final fg = isSelf ? AppColors.primary : AppColors.primaryDark;
    final bg = fg.withOpacity(0.10);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bg,
        border: Border.all(color: fg.withOpacity(0.30)),
      ),
      child: Text(
        isSelf ? "Self" : "Referral",
        style: TextStyle(
          fontSize: 12.2,
          fontWeight: FontWeight.w900,
          color: fg,
          height: 1.0,
        ),
      ),
    );
  }
}

/// ✅ More modern points pill (premium)
class LeadCardPointsPillModern extends StatelessWidget {
  final int points;

  const LeadCardPointsPillModern({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),

        // ✅ warm tint
        color: AppColors.background,
        border: Border.all(color: AppColors.border),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 18, color: AppColors.warning),
          const SizedBox(width: 4),
          Text(
            "$points pts",
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
