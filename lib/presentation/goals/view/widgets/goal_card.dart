import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.borderColor1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getRegularStyle16_400(color: ColorManager.brown400),
                ),
                SizedBox(height: 12.h),
                Text(
                  subtitle,
                  style: getRegularStyle16_400(
                    color: ColorManager.grayBlack400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.all(14.r),
              child: Icon(
                Icons.close,
                color: ColorManager.primaryButton,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
