import 'package:cash_prow/features/rewards/presentation/widgets/available_points_card.dart';
import 'package:cash_prow/features/rewards/presentation/widgets/cube_auto_slider.dart';
import 'package:cash_prow/features/rewards/presentation/widgets/featured_reward_card.dart';
import 'package:cash_prow/features/rewards/presentation/widgets/reward_list_tile.dart';
import 'package:flutter/material.dart';

class RedeemPointsScreen extends StatelessWidget {
  const RedeemPointsScreen({super.key});

  final int availablePoints = 1250;

  static final List<RewardItem> rewards = [
    RewardItem(
      title: "Bike",
      points: 12500,
      image: "assets/images/bike.png",
      code: "CP5",
    ),
    RewardItem(
      title: "Mobile",
      points: 3000,
      image: "assets/images/mobile.png",
      code: "CP6",
    ),
    RewardItem(
      title: "Laptop",
      points: 2000,
      image: "assets/images/laptop.png",
      code: "CP8",
    ),
    RewardItem(
      title: "Bag",
      points: 100,
      image: "assets/images/bag.png",
      code: "CP9",
    ),
    RewardItem(
      title: "Scooty",
      points: 5000,
      image: "assets/images/scooty.png",
      code: "CP7",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final featuredReward = rewards[3];

    return Scaffold(
      body: Column(
        children: [
          // 🔝 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.7)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: const [
                SizedBox(width: 16),
                BackButton(color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Redeem Points",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ⭐ POINTS
          AvailablePointsCard(points: availablePoints),

          const SizedBox(height: 20),

          // 🎠 CUBE SLIDER
          CubeAutoSlider(rewards: rewards),

          const SizedBox(height: 24),

          // 🎁 CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FeaturedRewardCard(
                  reward: featuredReward,
                  availablePoints: availablePoints,
                ),

                const SizedBox(height: 24),

                const Text(
                  "All Rewards",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 14),

                ...rewards.map(
                  (reward) => RewardListTile(
                    reward: reward,
                    availablePoints: availablePoints,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////
// 🎁 MODEL
//////////////////////////////////////////////////

class RewardItem {
  final String title;
  final int points;
  final String image;
  final String code;

  RewardItem({
    required this.title,
    required this.points,
    required this.image,
    required this.code,
  });
}
