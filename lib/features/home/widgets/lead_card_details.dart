import 'package:flutter/material.dart';
import 'package:cash_prow/features/leads/models/lead_model.dart';

class LeadMetaTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const LeadMetaTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: primary),
          const SizedBox(width: 8),

          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.hintColor,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            ":",
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Expanded Details Section
class LeadCardDetails extends StatelessWidget {
  final LeadModel lead;

  const LeadCardDetails({super.key, required this.lead});

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
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
    return "${date.day.toString().padLeft(2, '0')} "
        "${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tiles = <Widget>[
      LeadMetaTile(
        icon: Icons.shopping_bag_outlined,
        label: "Product",
        value: (lead.product ?? "-").trim(),
      ),
      LeadMetaTile(
        icon: Icons.login_rounded,
        label: "Login",
        value: _formatDate(lead.loginDate),
      ),
      LeadMetaTile(
        icon: Icons.event_outlined,
        label: "Status",
        value: _formatDate(lead.statusDate),
      ),
    ];

    if ((lead.referredBy ?? "").trim().isNotEmpty) {
      tiles.add(
        LeadMetaTile(
          icon: Icons.person_outline_rounded,
          label: "Referred",
          value: lead.referredBy!,
        ),
      );
    }

    if (lead.type == "Referral") {
      tiles.addAll([
        LeadMetaTile(
          icon: Icons.phone_outlined,
          label: "Phone",
          value: lead.contactPhone ?? "-",
        ),
        LeadMetaTile(
          icon: Icons.email_outlined,
          label: "Email",
          value: lead.contactEmail ?? "-",
        ),
      ]);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSingleColumn = constraints.maxWidth < 360;

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: tiles.map((tile) {
              return SizedBox(
                width: isSingleColumn
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 12) / 2,
                child: tile,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
