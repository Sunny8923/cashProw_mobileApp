import 'dart:ui';
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
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      // 🌈 Glow outline
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        gradient: LinearGradient(
          colors: [primary.withOpacity(0.55), primary.withOpacity(0.25)],
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.15),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: primary.withOpacity(0.12), // tinted glass
              borderRadius: BorderRadius.circular(_radius),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1.2,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(_radius),
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.all(_pad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LeadCardHeader(lead: widget.lead, expanded: _expanded),

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
        ),
      ),
    );
  }
}
