import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';
import 'package:flutter/material.dart';

class FeaturedRewardCard extends StatelessWidget {
  final RewardItem reward;
  final int availablePoints;

  const FeaturedRewardCard({
    super.key,
    required this.reward,
    required this.availablePoints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final canRedeem = availablePoints >= reward.points;

    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary.withOpacity(0.9), primary.withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Featured Reward",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reward.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${reward.points} pts",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: canRedeem ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primary,
                    ),
                    child: Text(canRedeem ? "Redeem Now" : "Not Enough"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(reward.image, width: 120),
          ),
        ],
      ),
    );
  }
}
