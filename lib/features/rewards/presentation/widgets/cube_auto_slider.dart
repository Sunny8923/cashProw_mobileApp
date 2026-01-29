import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cash_prow/features/rewards/presentation/screens/redeem_points_screen.dart';

class CubeAutoSlider extends StatefulWidget {
  final List<RewardItem> rewards;

  const CubeAutoSlider({super.key, required this.rewards});

  @override
  State<CubeAutoSlider> createState() => _CubeAutoSliderState();
}

class _CubeAutoSliderState extends State<CubeAutoSlider> {
  late PageController _controller;

  final int _fakeCount = 10000;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: _fakeCount ~/ 2);

    _autoSlide();
  }

  void _autoSlide() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));

      _controller.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  int _realIndex(int index) {
    return index % widget.rewards.length;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: PageView.builder(
        controller: _controller,
        itemCount: _fakeCount,
        itemBuilder: (context, index) {
          final real = _realIndex(index);

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double page = _controller.hasClients
                  ? _controller.page ?? _controller.initialPage.toDouble()
                  : _controller.initialPage.toDouble();

              double delta = index - page;
              delta = delta.clamp(-1.0, 1.0);

              final bool isNext = delta > 0;

              return Transform(
                alignment: isNext
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  // ✅ PURE CLOCKWISE CUBE ROTATION
                  ..rotateY(-delta * pi / 2),
                child: child,
              );
            },
            child: _CubeCard(reward: widget.rewards[real]),
          );
        },
      ),
    );
  }
}

class _CubeCard extends StatelessWidget {
  final RewardItem reward;

  const _CubeCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // 🔥 keeps rounded corners on image
      child: Image.asset(
        reward.image,
        width: double.infinity, // full screen width
        fit: BoxFit.fitWidth, // keeps original aspect ratio
      ),
    );
  }
}
