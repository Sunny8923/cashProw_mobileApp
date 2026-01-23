import 'package:cash_prow/core/theme/app_colors.dart';
import 'package:cash_prow/core/widgets/app_user_avatar.dart';
import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/features/profile/presentation/controllers/profile_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final profileState = ref.watch(profileControllerProvider);

    final user = authState.user;

    final displayName = user?.name?.trim().isNotEmpty == true
        ? user!.name!
        : "User";
    final displayEmail = user?.email ?? "-";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔝 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 54, bottom: 85),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
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
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 👤 AVATAR + upload icon
            Transform.translate(
              offset: const Offset(0, -52),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: AppColors.card,
                      child: AppUserAvatar(
                        radius: 50,
                        profileImageUrl: user?.profileImageUrl,
                        gender: user?.gender,
                      ),
                    ),
                  ),

                  // 📷 Upload button
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: InkWell(
                      onTap: profileState.uploading
                          ? null
                          : () async {
                              await ref
                                  .read(profileControllerProvider.notifier)
                                  .uploadProfilePicture();

                              final err = ref
                                  .read(profileControllerProvider)
                                  .error;
                              if (err != null && context.mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(err)));
                              }
                            },
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.22),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: profileState.uploading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                color: AppColors.primary,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 2),

            // 🧾 USER INFO
            Text(
              displayName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: AppColors.primary.withOpacity(0.85),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayEmail,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // 📦 INFO CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _ProfileTile(
                    icon: Icons.phone_rounded,
                    title: 'Phone',
                    value: user?.phone ?? "-",
                  ),
                  _ProfileTile(
                    icon: Icons.location_on_rounded,
                    title: 'Location',
                    value: user?.address ?? "-",
                  ),
                  _ProfileTile(
                    icon: Icons.star_rounded,
                    title: 'Points',
                    value: (user?.points ?? 0).toString(),
                    iconColor: AppColors.warning,
                    iconBg: AppColors.warning.withOpacity(0.12),
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

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? iconColor;
  final Color? iconBg;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    this.iconColor,
    this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final ic = iconColor ?? AppColors.primary;
    final bg = iconBg ?? AppColors.primary.withOpacity(0.10);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ic),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: AppColors.textPrimary,
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
