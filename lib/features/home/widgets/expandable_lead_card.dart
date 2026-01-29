import 'package:flutter/material.dart';
import 'package:cash_prow/features/leads/models/lead_model.dart';

import 'lead_card_header.dart';
import 'lead_card_details.dart';

class ExpandableLeadCard extends StatefulWidget {
  final LeadModel lead;

  const ExpandableLeadCard({super.key, required this.lead});

  @override
  State<ExpandableLeadCard> createState() => _ExpandableLeadCardState();
}

class _ExpandableLeadCardState extends State<ExpandableLeadCard> {
  bool _expanded = false;

  static const _radius = 18.0;
  static const _pad = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        gradient: LinearGradient(
          colors: [primary, primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      /// 🔹 Border thickness
      child: Container(
        margin: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          color: theme.cardColor, // ✅ SAME COLOR FOR ENTIRE CARD
          borderRadius: BorderRadius.circular(_radius - 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(_radius - 1),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(_pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ Header
                  LeadCardHeader(lead: widget.lead, expanded: _expanded),

                  /// ✅ Expand area (NO extra background)
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: _expanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: LeadCardDetails(lead: widget.lead),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
