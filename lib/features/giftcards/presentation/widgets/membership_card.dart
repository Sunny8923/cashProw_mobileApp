import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/membership_tier.dart';
import 'membership_card_front.dart';
import 'membership_card_back.dart';

class MembershipCard extends StatefulWidget {
  final MembershipTier tier;

  const MembershipCard({super.key, required this.tier});

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _flip() {
    if (_controller.isAnimating) return;

    _isFront ? _controller.forward() : _controller.reverse();
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    final config = membershipConfigs[widget.tier]!;

    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          final angle = _animation.value;
          final showFront = angle <= pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: showFront
                ? MembershipCardFront(config: config)
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: MembershipCardBack(config: config),
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
