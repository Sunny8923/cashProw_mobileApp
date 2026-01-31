import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';

class FeaturedRewardsCarousel extends StatefulWidget {
  final List<RewardItem> rewards;
  final int availablePoints;

  const FeaturedRewardsCarousel({
    super.key,
    required this.rewards,
    required this.availablePoints,
  });

  @override
  State<FeaturedRewardsCarousel> createState() =>
      _FeaturedRewardsCarouselState();
}

class _FeaturedRewardsCarouselState extends State<FeaturedRewardsCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        /// 🎠 CAROUSEL
        CarouselSlider(
          options: CarouselOptions(
            height: 260,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
            },
          ),
          items: widget.rewards.map((reward) {
            final canRedeem = widget.availablePoints >= reward.points;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary.withOpacity(0.9), primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    color: primary.withOpacity(0.35),
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LABEL
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      "Featured Reward",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// TITLE
                  Text(
                    reward.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// POINTS
                  Text(
                    "${reward.points} points required",
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),

                  const Spacer(),

                  /// CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: canRedeem ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        canRedeem ? "Redeem Now" : "Not Enough Points",
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        /// 🔘 DOT INDICATORS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.rewards.length, (index) {
            final isActive = index == _current;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? primary : Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}
