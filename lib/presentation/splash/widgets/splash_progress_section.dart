import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashProgressSection extends StatelessWidget {
  const SplashProgressSection({
    super.key,
    required this.showColorEffect,
    required this.progressController,
  });

  final bool showColorEffect;
  final AnimationController progressController;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showColorEffect ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          SizedBox(
            width: 220.w,
            child: AnimatedBuilder(
              animation: progressController,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return ColorManager.metallicGradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: LinearProgressIndicator(
                      value: progressController.value,
                      backgroundColor: ColorManager.primary.withAlpha(30),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      minHeight: 5.h,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            "Know what's safe to spend.",
            textAlign: TextAlign.center,
            style: getLight300Style16(color: ColorManager.gold),
          ),
        ],
      ),
    );
  }
}
