import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeadline extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;

  const AuthHeadline({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              (titleStyle ??
                      getBoldStyle24(
                        fontSize: (28.sp).clamp(28.0, 34.0),
                        color: ColorManager.brown,
                      ))
                  .copyWith(letterSpacing: -0.5),
        ),
        SizedBox(height: 15.h),
        Text(
          subtitle,
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
      ],
    );
  }
}
