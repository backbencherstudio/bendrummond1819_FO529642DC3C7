import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PlanFeatureRow extends StatelessWidget {
  const PlanFeatureRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Row(
        children: [
          SvgPicture.asset(IconManager.correct, width: 16.w, height: 16.h),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: getRegularStyle16_400(color: ColorManager.grayBlack400),
            ),
          ),
        ],
      ),
    );
  }
}