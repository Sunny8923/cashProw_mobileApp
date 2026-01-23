import 'package:flutter/material.dart';

class RedeemPointsScreen extends StatelessWidget {
  const RedeemPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int availablePoints = 1250;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔝 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff5B86E5), Color(0xff36D1DC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // 🔙 BACK
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Redeem Points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ AVAILABLE POINTS CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xff5B86E5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        color: Color(0xff5B86E5),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available Points',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$availablePoints pts',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🎁 REDEEM OPTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  _RedeemOption(
                    title: 'Mobile Recharge',
                    subtitle: 'Minimum 500 points',
                    pointsRequired: 500,
                    icon: Icons.phone_android,
                  ),
                  _RedeemOption(
                    title: 'Amazon Gift Card',
                    subtitle: 'Minimum 1000 points',
                    pointsRequired: 1000,
                    icon: Icons.card_giftcard,
                  ),
                  _RedeemOption(
                    title: 'Bank Transfer',
                    subtitle: 'Minimum 1500 points',
                    pointsRequired: 1500,
                    icon: Icons.account_balance,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// 🎁 REDEEM OPTION CARD
class _RedeemOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final int pointsRequired;
  final IconData icon;

  const _RedeemOption({
    required this.title,
    required this.subtitle,
    required this.pointsRequired,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff5B86E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xff5B86E5)),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              // TODO: Redeem action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5B86E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Redeem'),
          ),
        ],
      ),
    );
  }
}
