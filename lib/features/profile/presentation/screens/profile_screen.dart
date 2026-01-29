import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/features/profile/presentation/controllers/profile_controllers.dart';
import 'package:cash_prow/features/profile/presentation/widgets/address_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/phone_email_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_bottom_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_completion_card.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_header.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_tile.dart';
import 'package:cash_prow/features/profile/presentation/widgets/selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final profileState = ref.watch(profileControllerProvider);

    final user = authState.user;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final card = theme.cardColor;
    final border = theme.dividerColor;
    final textSecondary = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    final completion = _profileCompletion(user);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔝 HEADER
            ProfileHeader(user: user),
            SizedBox(height: 50),

            /// 📊 PROFILE COMPLETION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ProfileCompletionCard(
                completion: completion,
                primary: primary,
                border: border,
                textSecondary: textSecondary,
              ),
            ),

            const SizedBox(height: 18),

            /// 📦 DETAILS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProfileTile(
                    icon: Icons.phone_rounded,
                    title: 'Phone',
                    value: user?.phone ?? "-",
                    onTap: () => openProfileBottomSheet(
                      context: context,
                      child: const PhoneEmailSheet(
                        title: "Change Phone Number",
                        hint: "Enter new phone number",
                        otpTargetLabel: "your mobile",
                      ),
                    ),
                  ),

                  ProfileTile(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: user?.email ?? "-",
                    onTap: () => openProfileBottomSheet(
                      context: context,
                      child: const PhoneEmailSheet(
                        title: "Change Email Address",
                        hint: "Enter new email address",
                        otpTargetLabel: "your email",
                      ),
                    ),
                  ),

                  ProfileTile(
                    icon: Icons.location_on_rounded,
                    title: 'Address',
                    value: user?.address?.isNotEmpty == true
                        ? user!.address!
                        : "Add full address",
                    onTap: profileState.updating
                        ? null
                        : () => openProfileBottomSheet(
                            context: context,
                            child: AddressSheet(
                              onSave: (address) {
                                ref
                                    .read(profileControllerProvider.notifier)
                                    .updateProfile(address: address);
                              },
                            ),
                          ),
                  ),

                  ProfileTile(
                    icon: Icons.work_outline_rounded,
                    title: 'Occupation',
                    value: user?.occupation ?? "Add occupation",
                    onTap: profileState.updating
                        ? null
                        : () => openProfileBottomSheet(
                            context: context,
                            child: SelectSheet(
                              title: "Select Occupation",
                              options: const [
                                "Salaried",
                                "Business",
                                "Self_Employed",
                                "Student",
                                "Retired",
                                "Other",
                              ],
                              onSelected: (v) {
                                ref
                                    .read(profileControllerProvider.notifier)
                                    .updateProfile(occupation: v);
                              },
                            ),
                          ),
                  ),

                  ProfileTile(
                    icon: Icons.currency_rupee_rounded,
                    title: 'Monthly Income',
                    value: user?.salary != null
                        ? "₹${user!.salary!.toInt()}"
                        : "Select income range",
                    onTap: profileState.updating
                        ? null
                        : () => openProfileBottomSheet(
                            context: context,
                            child: SelectSheet(
                              title: "Select Monthly Income",
                              options: const [
                                "Below 25k",
                                "25k – 50k",
                                "50k – 1L",
                                "1L – 2L",
                                "Above 2L",
                              ],
                              onSelected: (range) {
                                final salary = mapIncomeRangeToSalary(range);

                                ref
                                    .read(profileControllerProvider.notifier)
                                    .updateProfile(salary: salary);
                              },
                            ),
                          ),
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

double _profileCompletion(user) {
  if (user == null) return 0;

  double score = 0;

  if (user.name?.isNotEmpty == true) score += 10;
  if (user.profileImageUrl?.isNotEmpty == true) score += 10;
  if (user.phone?.isNotEmpty == true) score += 15;
  if (user.email?.isNotEmpty == true) score += 15;
  if (user.address?.isNotEmpty == true) score += 15;
  if (user.gender?.isNotEmpty == true) score += 5;
  if (user.occupation?.isNotEmpty == true) score += 15;

  // ✅ salary instead of incomeRange
  if (user.salary != null && user.salary! > 0) score += 15;

  return score.clamp(0, 100);
}

double mapIncomeRangeToSalary(String range) {
  switch (range) {
    case "Below 25k":
      return 20000;
    case "25k – 50k":
      return 40000;
    case "50k – 1L":
      return 75000;
    case "1L – 2L":
      return 150000;
    case "Above 2L":
      return 250000;
    default:
      return 0;
  }
}
