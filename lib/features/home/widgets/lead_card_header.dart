import 'package:flutter/material.dart';
import 'package:cash_prow/features/leads/models/lead_model.dart';
import 'package:cash_prow/core/theme/app_colors.dart';
import 'lead_card_pills.dart';

class LeadCardHeader extends StatelessWidget {
  final LeadModel lead;
  final bool expanded;

  const LeadCardHeader({super.key, required this.lead, required this.expanded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final name = lead.name.trim().isEmpty ? "Unknown" : lead.name.trim();
    final status = (lead.status ?? "New").trim();
    final product = (lead.product ?? "-").trim();
    final type = lead.type.trim();

    final amountText = lead.amount == null
        ? "-"
        : "₹ ${lead.amount!.toStringAsFixed(0)}";

    /// ✅ Micro animation values
    final headerScale = expanded ? 1.0 : 0.985;
    final avatarScale = expanded ? 1.0 : 0.92;
    final pointsScale = expanded ? 1.0 : 0.96;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ✅ MAIN HERO PANEL (micro animated)
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: headerScale),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              /// ✅ Clean surface
              color: AppColors.background,

              /// ✅ Neutral border
              border: Border.all(color: AppColors.border),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(expanded ? 0.05 : 0.03),
                  blurRadius: expanded ? 14 : 10,
                  offset: Offset(0, expanded ? 8 : 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Row 1: Avatar + Name/Meta + Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ✅ Avatar micro bounce
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: avatarScale),
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutBack,
                      builder: (context, scale, child) {
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: const LeadCardAvatar(),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// name + type pill
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3,
                                    height: 1.12,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              /// ✅ Type pill micro fade
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 180),
                                opacity: expanded ? 1.0 : 0.92,
                                child: LeadCardTypePillOutlined(type: type),
                              ),
                            ],
                          ),

                          const SizedBox(height: 7),

                          /// product line
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 16,
                                color: AppColors.primary.withOpacity(0.85),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  product,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// status pill with dot
                    LeadCardStatusPillDot(status: status),
                  ],
                ),

                const SizedBox(height: 12),

                /// ✅ Amount Panel (slide+fade micro)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, anim) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(anim);

                    final fade = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(anim);

                    return FadeTransition(
                      opacity: fade,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: Container(
                    key: ValueKey(expanded),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),

                      /// ✅ Brand tinted gradient
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(expanded ? 0.14 : 0.10),
                          AppColors.primaryLight.withOpacity(
                            expanded ? 0.12 : 0.08,
                          ),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      border: Border.all(
                        color: AppColors.primary.withOpacity(
                          expanded ? 0.25 : 0.18,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Loan Amount",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.2,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                amountText,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.55,
                                  color: AppColors.textPrimary,
                                  height: 1.04,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// ✅ Points micro scale
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: pointsScale),
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutBack,
                          builder: (context, scale, child) {
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: LeadCardPointsPillModern(points: lead.points),
                        ),
                      ],
                    ),
                  ),
                ),

                /// referral line
                if (type.toLowerCase() == "referral" &&
                    (lead.referredBy ?? "").trim().isNotEmpty) ...[
                  const SizedBox(height: 10),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: expanded ? 1.0 : 0.85,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 16,
                          color: AppColors.primary.withOpacity(0.85),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Referred by ${lead.referredBy}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        /// ✅ Divider + arrow section
        Row(
          children: [
            Expanded(
              child: Divider(height: 1, thickness: 1, color: AppColors.border),
            ),
            const SizedBox(width: 10),
            AnimatedRotation(
              turns: expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: AppColors.primary.withOpacity(0.9),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Divider(height: 1, thickness: 1, color: AppColors.border),
            ),
          ],
        ),
      ],
    );
  }
}
