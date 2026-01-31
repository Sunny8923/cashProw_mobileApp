import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cash_prow/features/profile/presentation/controllers/profile_controllers.dart';
import 'package:cash_prow/features/profile/presentation/widgets/address_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/phone_email_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_bottom_sheet.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_header.dart';
import 'package:cash_prow/features/profile/presentation/widgets/profile_tile.dart';
import 'package:cash_prow/features/profile/presentation/widgets/selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final profileState = ref.watch(profileControllerProvider);

    final user = authState.user;
    final completion = _profileCompletion(user);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🎨 NEW CLEAN HEADER
            ProfileHeader(user: user, completion: completion),

            /// 📦 FLOATING PROFILE CARD
            Transform.translate(
              offset: const Offset(0, -150),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 18,
                        color: Colors.black.withOpacity(0.08),
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// 🏅 SILVER BADGE
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF1F5F9), // light silver
                                Color(0xFFE5E7EB), // darker silver
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.08),
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.workspace_premium_rounded,
                                size: 15,
                                color: Color(0xFF6B7280),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Silver Member",
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4B5563),
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

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
                                        .read(
                                          profileControllerProvider.notifier,
                                        )
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
                                        .read(
                                          profileControllerProvider.notifier,
                                        )
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
                                    final salary = mapIncomeRangeToSalary(
                                      range,
                                    );

                                    ref
                                        .read(
                                          profileControllerProvider.notifier,
                                        )
                                        .updateProfile(salary: salary);
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(),
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
