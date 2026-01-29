import 'package:flutter/material.dart';
import '../../data/membership_tier.dart';
import '../widgets/membership_card.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Membership Cards")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MembershipCard(tier: MembershipTier.silver),
          SizedBox(height: 20),
          MembershipCard(tier: MembershipTier.gold),
          SizedBox(height: 20),
          MembershipCard(tier: MembershipTier.vip),
        ],
      ),
    );
  }
}
