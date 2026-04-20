import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final double borderRadius;
  final double fontSize;
  final Color? fillColor;
  final Widget? icon;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color = const Color(0xFF8B66FF),
    this.borderRadius = 12,
    this.fontSize = 18,
    this.fillColor,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: fillColor ?? ColorManager.customOutlineButton,
          border: Border.all(color: ColorManager.customOutlineButtonBorder, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10.w),
            ],
            Text(
              title,
              style: textStyle ??
                  getBoldStyle(
                    color: ColorManager.black400,
                    fontSize: fontSize.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}