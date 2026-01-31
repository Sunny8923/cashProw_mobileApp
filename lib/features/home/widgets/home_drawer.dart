import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:cash_prow/core/theme/app_colors.dart';

import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_prow/features/profile/presentation/screens/profile_screen.dart';
import 'package:cash_prow/features/referal/presentation/screens/add_referral_screen.dart';
import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';
import 'package:cash_prow/features/giftcards/presentation/screens/gift_card_screen.dart';
import 'package:cash_prow/features/tools/emicalculator/emi_calculator.dart';
import 'package:cash_prow/features/tutorials/screens/demo_video_screen.dart';
import 'package:cash_prow/features/support/presentation/screens/help_and_support_screen.dart';
import 'package:cash_prow/features/settings/screens/settings_screen.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primary = Theme.of(context).colorScheme.primary;

    final user = ref.watch(authControllerProvider).user;

    final displayName = user?.name?.trim().isNotEmpty == true
        ? user!.name!
        : "User";
    final displayEmail = user?.email ?? "-";

    return Drawer(
      child: Column(
        children: [
          _header(primary, displayName, displayEmail, user),

          const SizedBox(height: 10),

          _item(
            context,
            icon: Icons.home_rounded,
            title: 'Home',
            primary: primary,
            active: true,
            onTap: () => Navigator.pop(context),
          ),

          _item(
            context,
            icon: Icons.person_rounded,
            title: 'Profile',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.person_add_alt_1_rounded,
            title: 'Add Referral',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddReferralScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.money,
            title: 'Redeem',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RedeemPointsScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.card_giftcard,
            title: 'Gift Cards',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GiftCardScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.calculate,
            title: 'Emi Calculator',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmiCalculatorScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.video_call,
            title: 'Demo Videos',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DemoVideosScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
            ),
          ),

          _item(
            context,
            icon: Icons.settings_rounded,
            title: 'Settings',
            primary: primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: GestureDetector(
              onTap: () async {
                await ref.read(authControllerProvider.notifier).logout();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: primary),
                    const SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI PARTS =================

  Widget _header(Color primary, String name, String email, dynamic user) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primary, primary.withOpacity(0.75)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 20,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.card,
                  child: AppUserAvatar(
                    radius: 28,
                    profileImageUrl: user?.profileImageUrl,
                    gender: user?.gender,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(email, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color primary,
    bool active = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.card : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: active ? primary : Colors.grey[700]),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: active ? FontWeight.bold : FontWeight.w500,
                  color: active ? primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
