import 'package:flutter/material.dart';

class StaggeredFadeSlide extends StatelessWidget {
  final Animation<double> controller;
  final double delay;
  final Widget child;

  const StaggeredFadeSlide({
    super.key,
    required this.controller,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = delay.clamp(0.0, 1.0);
    final end = (delay + 0.4).clamp(0.0, 1.0);
    final curved = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, (1 - curved.value) * 24),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

