import 'dart:math';
import 'package:flutter/material.dart';

class AppUserAvatar extends StatelessWidget {
  final String? profileImageUrl;
  final String? gender;
  final double radius;

  final double? completion;
  final List<Color>? gradientColors;
  final double strokeWidth;

  const AppUserAvatar({
    super.key,
    required this.profileImageUrl,
    required this.gender,
    this.radius = 22,
    this.completion,
    this.gradientColors,
    this.strokeWidth = 6,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        profileImageUrl != null &&
        profileImageUrl!.trim().isNotEmpty &&
        profileImageUrl != "null";

    final assetPath = (gender == "Female")
        ? "assets/avatars/female.jpg"
        : "assets/avatars/male.jpg";

    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: hasImage
          ? NetworkImage(profileImageUrl!)
          : AssetImage(assetPath) as ImageProvider,
    );

    if (completion == null) return avatar;

    final colors =
        gradientColors ?? const [Color(0xFF4FACFE), Color(0xFF00C6FB)];

    return SizedBox(
      width: (radius + strokeWidth) * 2,
      height: (radius + strokeWidth) * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size((radius + strokeWidth) * 2, (radius + strokeWidth) * 2),
            painter: _GradientRingPainter(
              progress: completion!.clamp(0, 100) / 100,
              strokeWidth: strokeWidth,
              colors: colors,
            ),
          ),
          avatar,
        ],
      ),
    );
  }
}

class _GradientRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> colors;

  _GradientRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - strokeWidth / 2;

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final fgPaint = Paint()
      ..shader = SweepGradient(
        colors: colors,
        startAngle: -pi / 2,
        endAngle: 2 * pi,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
