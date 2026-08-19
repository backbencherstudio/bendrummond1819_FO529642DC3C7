import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanBillingToggle extends StatelessWidget {
  const PlanBillingToggle({
    super.key,
    required this.isMonthly,
    required this.onChanged,
  });

  final bool isMonthly;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 220.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEFE9DE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _PlanToggleItem(
                  label: 'Monthly',
                  isActive: isMonthly,
                  onTap: () => onChanged(true),
                ),
                _PlanToggleItem(
                  label: 'Yearly',
                  isActive: !isMonthly,
                  onTap: () => onChanged(false),
                ),
              ],
            ),
          ),
          Positioned(
            right: -50.5.w,
            top: -8.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorManager.goldAccent,
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                'Best Value',
                style: getLightStyle12_400(color: ColorManager.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanToggleItem extends StatelessWidget {
  const _PlanToggleItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isActive
                ? ColorManager.textPrimary
                : ColorManager.transparentColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: getLightStyle14_400(
              color: isActive
                  ? ColorManager.whiteColor
                  : ColorManager.grayBlack400,
            ),
          ),
        ),
      ),
    );
  }
}