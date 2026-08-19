import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/widgets/plan_feature_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.isMonthly,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.isLoading,
    required this.features,
  });

  final bool isMonthly;
  final String? monthlyPrice;
  final String? yearlyPrice;
  final bool isLoading;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    final price = isMonthly
        ? (monthlyPrice ?? '\$3.99')
        : (yearlyPrice ?? '\$39.99');
    final period = isMonthly ? '/month' : '/year';
    final label = isMonthly ? 'Billed every month' : 'Billed every year';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.backgroundPressed100,
          width: 1.5.w,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isMonthly ? 'Monthly' : 'Yearly',
                      style: getBoldStyle24(color: ColorManager.grayBlack400),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      label,
                      style: getRegularStyle16_400(
                        color: ColorManager.grayBlack400,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        isLoading ? '...' : price,
                        style:
                            getBoldStyle32(color: ColorManager.textPrimary),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      period,
                      style: getRegularStyle14_400(
                        color: ColorManager.grayBlack400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          for (final feature in features) PlanFeatureRow(text: feature),
        ],
      ),
    );
  }
}