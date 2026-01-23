import 'package:flutter/material.dart';
import 'package:cash_prow/features/leads/models/lead_model.dart';
import 'package:cash_prow/core/theme/app_colors.dart';

class LeadCardDetails extends StatelessWidget {
  final LeadModel lead;

  const LeadCardDetails({super.key, required this.lead});

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  String _monthName(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final product = (lead.product ?? "-").trim();

    final items = <_DetailItem>[
      _DetailItem(Icons.shopping_bag_outlined, "Product", product),
      _DetailItem(Icons.login_rounded, "Login", _formatDate(lead.loginDate)),
      _DetailItem(Icons.event_outlined, "Status", _formatDate(lead.statusDate)),
      if ((lead.referredBy ?? "").trim().isNotEmpty)
        _DetailItem(Icons.person_outline_rounded, "Referred", lead.referredBy!),
      if (lead.type == "Referral") ...[
        _DetailItem(Icons.phone_outlined, "Phone", lead.contactPhone ?? "-"),
        _DetailItem(Icons.email_outlined, "Email", lead.contactEmail ?? "-"),
      ],
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ✅ Warm tinted inner container
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items.map((e) {
              return SizedBox(
                width: isNarrow
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 12) / 2,
                child: _detailTile(e, theme),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _detailTile(_DetailItem item, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Brand icon
        Icon(item.icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailItem {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem(this.icon, this.label, this.value);
}
