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
  final valueCtrl = TextEditingController();
  final otpCtrl = TextEditingController();

  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800)),

        const SizedBox(height: 16),

        if (!otpSent)
          TextField(
            controller: valueCtrl,
            decoration: InputDecoration(labelText: widget.hint),
          )
        else
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("OTP sent to ${valueCtrl.text}"),
          ),

        const SizedBox(height: 14),

        TextField(
          controller: otpCtrl,
          enabled: otpSent,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(labelText: "Enter OTP"),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: profileState.otpLoading
                ? null
                : () async {
                    if (!otpSent) {
                      await controller.requestEmailOtp(valueCtrl.text);
                      setState(() => otpSent = true);
                    } else {
                      await controller.verifyEmailOtp(
                        valueCtrl.text,
                        otpCtrl.text,
                      );
                      Navigator.pop(context);
                    }
                  },
            child: Text(!otpSent ? "Send OTP" : "Verify"),
          ),
        ),
      ],
    );
  }
}
