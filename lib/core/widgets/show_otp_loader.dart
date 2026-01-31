import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 🔄 LOADING (sending OTP)
void showOtpLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: SizedBox(
          height: 260,
          width: 260,
          child: Lottie.asset(
            "assets/lottie/send_otp.json",
            repeat: true,
            fit: BoxFit.contain,
          ),
        ),
      );
    },
  );
}

void hideOtpLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

/// ✅ SUCCESS
void showOtpSuccess(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: SizedBox(
          height: 220,
          width: 220,
          child: Lottie.asset(
            "assets/lottie/done.json",
            repeat: false,
            fit: BoxFit.contain,
          ),
        ),
      );
    },
  );
}

/// ❌ FAILED
void showOtpFailed(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: SizedBox(
          height: 220,
          width: 220,
          child: Lottie.asset(
            "assets/lottie/failed.json",
            repeat: false,
            fit: BoxFit.contain,
          ),
        ),
      );
    },
  );
}
