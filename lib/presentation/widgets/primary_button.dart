import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resource/constants/color_manger.dart';
import '../../core/resource/utils.dart';


class PrimaryButton extends StatelessWidget {
  final String title;
  final double? borderRadius;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? containerColor;
  final Border? border;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    this.borderRadius,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.padding,
    this.textStyle,
    this.containerColor,
    this.border,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 52.h,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          color: ColorManager.primaryButton,
          border: border ?? Border.all(color: ColorManager.transparentColor),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            height: 24.r,
            width: 24.r,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: ColorManager.whiteColor,
            ),
          )
              : FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: textStyle ?? getSemiBoldStyle22(color: ColorManager.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}