import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_prow/features/giftcards/presentation/screens/gift_card_screen.dart';
import 'package:cash_prow/features/leads/presentation/providers/leads_controller.dart';
import 'package:cash_prow/features/profile/presentation/screens/profile_screen.dart';
import 'package:cash_prow/features/referal/presentation/screens/add_referral_screen.dart';
import 'package:cash_prow/features/support/presentation/screens/help_and_support_screen.dart';
import 'package:cash_prow/features/tools/emicalculator/emi_calculator.dart';
import 'package:cash_prow/features/tutorials/screens/demo_video_screen.dart';
import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';
import 'package:cash_prow/features/home/widgets/expandable_lead_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/screens/settings_screen.dart';
import 'package:cash_prow/core/theme/app_colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(leadsControllerProvider.notifier).fetchLeads();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    final leadsState = ref.watch(leadsControllerProvider);
    final leads = leadsState.leads;

    final displayName = user?.name?.trim().isNotEmpty == true
        ? user!.name!
        : "User";
    final displayEmail = user?.email ?? "-";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,

        /// ☰ Custom Drawer Button
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 28, // 🔥 bigger hamburger
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        /// 🏷 Center Logo
        title: SizedBox(
          height: 36,
          child: Image.asset(
            "assets/images/logo_white.png",
            fit: BoxFit.contain,
          ),
        ),

        /// ➕ Add Referral Button
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 26, // 🔥 slightly large
            ),
            tooltip: "Add Referral",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddReferralScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            // 🔥 HEADER
            Stack(
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
                            displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            displayEmail,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            drawerCard(
              context: context,
              icon: Icons.home_rounded,
              title: 'Home',
              isActive: true,
              primary: primary,
              onTap: () => Navigator.pop(context),
            ),
            drawerCard(
              context: context,
              icon: Icons.person_rounded,
              title: 'Profile',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.money,
              title: 'Redeem',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RedeemPointsScreen()),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.card_giftcard,
              title: 'Gift Cards',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GiftCardScreen()),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.calculate,
              title: 'Emi Calculator',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EmiCalculatorScreen(),
                  ),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.video_call,
              title: 'Demo Videos',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DemoVideosScreen()),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.help,
              title: 'Help & Support',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                );
              },
            ),
            drawerCard(
              context: context,
              icon: Icons.settings_rounded,
              title: 'Settings',
              primary: primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),

            const Spacer(),

            // 🚪 Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  await ref.read(authControllerProvider.notifier).logout();

                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
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
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(leadsControllerProvider.notifier).fetchLeads();
        },
        child: Builder(
          builder: (_) {
            if (leadsState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (leadsState.error != null) {
              return Center(child: Text(leadsState.error!));
            }

            if (leads.isEmpty) {
              return const Center(child: Text("No leads found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leads.length,
              itemBuilder: (context, index) {
                final lead = leads[index];
                return ExpandableLeadCard(lead: lead);
              },
            );
          },
        ),
      ),
    );
  }

  Widget drawerCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color primary,
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.card : Colors.white,
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
              Icon(icon, color: isActive ? primary : Colors.grey[700]),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
