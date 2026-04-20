import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resource/constants/color_manger.dart';

Padding customBackButton(
    BuildContext context, {
      VoidCallback? onPressed,
      Color? color,
    }) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 48.h,
      width: 48.w,
      decoration: BoxDecoration(
        color: color ?? ColorManager.backButtonColor,
        border: Border.all(color: ColorManager.borderColor3, width: 0.5.w),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: ColorManager.navicons,
          size: 16.sp,
        ),
        onPressed: onPressed ?? () => Navigator.pop(context),
      ),
    ),
  );
}