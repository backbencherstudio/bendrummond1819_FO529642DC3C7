import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanErrorBanner extends StatelessWidget {
  const PlanErrorBanner({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.redColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: getLightStyle14_400(color: ColorManager.redColor),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onRetry,
            child: Text(
              'Retry',
              style: getLightStyle14_500(color: ColorManager.goldAccent),
            ),
          ),
        ],
      ),
    );
  }
}