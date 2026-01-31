import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeSummaryCard extends StatelessWidget {
  final int totalPoints;
  final int selfLeads;
  final int referralLeads;
  final int approvedLeads;
  final int pendingLeads;

  const HomeSummaryCard({
    super.key,
    required this.totalPoints,
    required this.selfLeads,
    required this.referralLeads,
    required this.approvedLeads,
    required this.pendingLeads,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        // 🌈 Glow background
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [primary.withOpacity(0.85), primary.withOpacity(0.35)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        GlassmorphicContainer(
          width: double.infinity,
          height: 140,
          borderRadius: 26,
          blur: 10,
          alignment: Alignment.center,
          border: 1.6,

          linearGradient: LinearGradient(
            colors: [primary.withOpacity(0.55), primary.withOpacity(0.25)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.6),
              Colors.white.withOpacity(0.1),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔥 Inline header row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const SizedBox(width: 7),
                    const Text(
                      "Total Points",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _animatedNumber(totalPoints, big: true),
                  ],
                ),

                // 📊 Stats Row
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _stat("Self", selfLeads),
                        _stat("Referral", referralLeads),
                        _stat("Approved", approvedLeads),
                        _stat("Pending", pendingLeads),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ✨ Glass reflection
        Positioned(
          top: 7,
          left: 12,
          right: 12,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.35),
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _animatedNumber(int value, {bool big = false}) {
    return Text(
          value.toString(),
          style: TextStyle(
            fontSize: big ? 30 : 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.25, end: 0)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  Widget _stat(String label, int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _animatedNumber(value),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
