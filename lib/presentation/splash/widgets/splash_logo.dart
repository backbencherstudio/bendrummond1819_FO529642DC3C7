import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    required this.showColorEffect,
    required this.shimmerController,
    required this.punchEffectController,
    required this.bounceAnimation,
  });

  final bool showColorEffect;
  final AnimationController shimmerController;
  final AnimationController punchEffectController;
  final Animation<double> bounceAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([shimmerController, punchEffectController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, bounceAnimation.value),
          child: showColorEffect
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: const [
                        Color(0xFF4A3A2F),
                        Color(0xFFB08A70),
                        Color(0xFF4A3A2F),
                      ],
                      stops: [
                        shimmerController.value - 0.3,
                        shimmerController.value,
                        shimmerController.value + 0.3,
                      ],
                    ).createShader(bounds);
                  },
                  child: _buildText(Colors.white),
                )
              : _buildText(const Color(0xFF4A3A2F)),
        );
      },
    );
  }

  Widget _buildText(Color color) {
    return Text(
      "STABILITY",
      style: getBoldStyle32(color: color).copyWith(letterSpacing: 8),
    );
  }
}
