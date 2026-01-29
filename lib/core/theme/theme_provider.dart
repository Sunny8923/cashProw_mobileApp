import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeNotifier, Color>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<Color> {
  @override
  Color build() {
    return const Color(0xFF8B0000); // default primary
  }

  void updatePrimary(Color color) {
    state = color;
  }
}
