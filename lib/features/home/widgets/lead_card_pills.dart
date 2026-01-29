import 'package:flutter/material.dart';
import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadCardAvatar extends ConsumerWidget {
  const LeadCardAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final primaryLight = primary.withOpacity(0.5);

    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [primary, primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.22),
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

/// Status pill with dot indicator
class LeadCardStatusPillDot extends StatelessWidget {
  final String status;

  const LeadCardStatusPillDot({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final success = Colors.green; // you can make this dynamic if added to Theme
    final warning = Colors.orange; // dynamic optional

    final s = status.toLowerCase();

    final isGreen = s == 'disbursed' || s == 'approved';
    final isWarning = s == 'pending' || s == 'in progress' || s == 'new';

    final fg = isGreen ? success : (isWarning ? warning : primary);
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

/// Outlined type pill
class LeadCardTypePillOutlined extends StatelessWidget {
  final String type;

  const LeadCardTypePillOutlined({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final primaryDark = primary.withOpacity(0.8);

    final isSelf = type.toLowerCase() == "self";

    final fg = isSelf ? primary : primaryDark;
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

/// Modern points pill
class LeadCardPointsPillModern extends StatelessWidget {
  final int points;

  const LeadCardPointsPillModern({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final border = theme.dividerColor;
    final background = theme.cardColor;
    final warning = Colors.orange; // optional: make dynamic in ThemeData

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: background,
        border: Border.all(color: border),
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
          Icon(Icons.star_rounded, size: 18, color: warning),
          const SizedBox(width: 4),
          Text(
            "$points pts",
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.textTheme.bodyLarge?.color ?? primary,
            ),
          ),
        ],
      ),
    );
  }
}
