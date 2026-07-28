import 'package:flutter/material.dart';

class KeyboardAwareHeader extends StatelessWidget {
  final Widget child;
  final double expandedHeightFactor;
  final double collapsedHeightFactor;
  final Duration duration;

  const KeyboardAwareHeader({
    super.key,
    required this.child,
    this.expandedHeightFactor = 0.58,
    this.collapsedHeightFactor = 0.25,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final height = keyboardOpen
        ? screenHeight * collapsedHeightFactor
        : screenHeight * expandedHeightFactor;

    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeOut,
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}
