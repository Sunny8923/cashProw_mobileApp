import 'package:cash_prow/core/app_root.dart';
import 'package:cash_prow/core/theme/app_theme.dart';
import 'package:cash_prow/core/theme/theme_provider.dart';
import 'package:cash_prow/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(primaryColor),
      home: AppRoot(),
    );
  }
}
