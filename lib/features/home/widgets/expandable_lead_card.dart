import 'package:flutter/material.dart';
import 'package:cash_prow/features/leads/models/lead_model.dart';
import 'package:cash_prow/core/theme/app_colors.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),

        // ✅ Brand gradient border
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
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
      child: Container(
        margin: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          // ✅ Warm tinted surface
          color: AppColors.background,
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

                  /// ✅ Expand area
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
