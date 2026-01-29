import 'package:flutter/material.dart';

class ProfileCompletionCard extends StatelessWidget {
  final double completion;
  final Color primary;
  final Color border;
  final Color textSecondary;

  const ProfileCompletionCard({
    required this.completion,
    required this.primary,
    required this.border,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(
                  value: completion / 100,
                  strokeWidth: 5,
                  color: primary,
                ),
              ),
              Text("${completion.toInt()}%"),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              completion < 100
                  ? "Complete your profile to get better leads"
                  : "Profile completed 🎉",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
