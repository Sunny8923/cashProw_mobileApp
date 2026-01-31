import 'package:flutter/material.dart';
import '../../data/membership_tier.dart';
import '../widgets/membership_card.dart';
import 'package:cash_prow/core/widgets/app_back_button.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Column(
        children: [
          /// 🔝 GRADIENT HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: const [
                SizedBox(width: 16),
                AppBackButton(),
                SizedBox(width: 12),
                Text(
                  "Membership Cards",
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

          /// 📋 CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                MembershipCard(tier: MembershipTier.silver),
                SizedBox(height: 20),
                MembershipCard(tier: MembershipTier.gold),
                SizedBox(height: 20),
                MembershipCard(tier: MembershipTier.vip),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
