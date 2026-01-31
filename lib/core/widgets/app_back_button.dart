import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Color iconColor;
  final double size;

  const AppBackButton({
    super.key,
    this.iconColor = Colors.white,
    this.size = 38,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.15)),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: size * 0.47,
          color: iconColor,
        ),
      ),
    );
  }
}
