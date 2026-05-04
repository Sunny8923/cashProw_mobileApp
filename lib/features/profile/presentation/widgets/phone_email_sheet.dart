import 'package:cash_prow/core/widgets/show_otp_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_controllers.dart';

class PhoneEmailSheet extends ConsumerStatefulWidget {
  final String title;
  final String hint;
  final String otpTargetLabel;

  const PhoneEmailSheet({
    super.key,
    required this.title,
    required this.hint,
    required this.otpTargetLabel,
  });

  @override
  ConsumerState<PhoneEmailSheet> createState() => _PhoneEmailSheetState();
}

class _PhoneEmailSheetState extends ConsumerState<PhoneEmailSheet> {
  final TextEditingController valueCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();

  bool otpSent = false;

  @override
  void dispose() {
    valueCtrl.dispose();
    otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              /// ===== VALUE INPUT OR SUCCESS BOX =====
              if (!otpSent)
                TextField(
                  controller: valueCtrl,
                  keyboardType: widget.hint.contains("phone")
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: widget.hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "OTP sent to ${valueCtrl.text}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

              const SizedBox(height: 14),

              /// ===== OTP FIELD =====
              TextField(
                controller: otpCtrl,
                enabled: otpSent,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ===== BUTTON =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (profileState.otpLoading) return;

                    /// ===== SEND OTP =====
                    if (!otpSent) {
                      if (valueCtrl.text.trim().isEmpty) return;

                      showOtpLoader(context);

                      await controller.requestEmailOtp(valueCtrl.text.trim());

                      hideOtpLoader(context);

                      if (mounted) {
                        setState(() => otpSent = true);
                      }
                    }
                    /// ===== VERIFY OTP =====
                    else {
                      if (otpCtrl.text.trim().length < 6) return;

                      final isSuccess = await controller.verifyEmailOtp(
                        valueCtrl.text.trim(),
                        otpCtrl.text.trim(),
                      );

                      if (isSuccess) {
                        showOtpSuccess(context);

                        await Future.delayed(
                          const Duration(milliseconds: 1500),
                        );

                        hideOtpLoader(context);

                        if (mounted) {
                          Navigator.pop(context);
                        }
                      } else {
                        showOtpFailed(context);

                        await Future.delayed(
                          const Duration(milliseconds: 1500),
                        );

                        hideOtpLoader(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    !otpSent ? "Send OTP" : "Verify",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
