import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? fillColor;
  final Widget? icon;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.fillColor,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: fillColor ?? ColorManager.backgroundSecondary,
            border: Border.all(
              color: color ?? ColorManager.customOutlineButtonBorder,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: FittedBox(fit: BoxFit.contain, child: icon!),
                ),
                SizedBox(width: 10.w),
              ],
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      textStyle ??
                      getRegularStyle20_500(
                        color: ColorManager.grayBlack400,
                        fontSize: 18.sp,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

