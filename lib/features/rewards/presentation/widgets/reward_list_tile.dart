import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';
import 'package:flutter/material.dart';

class RewardListTile extends StatelessWidget {
  final RewardItem reward;
  final int availablePoints;

  const RewardListTile({
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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(reward.image, width: 40),
        title: Text(reward.title),
        subtitle: Text("${reward.points} pts"),
        trailing: ElevatedButton(
          onPressed: canRedeem ? () {} : null,
          style: ElevatedButton.styleFrom(backgroundColor: primary),
          child: const Text("Redeem"),
        ),
      ),
    );
  }
}
