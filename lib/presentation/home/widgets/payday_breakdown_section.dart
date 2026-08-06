import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'breakdown_row.dart';

class PaydayBreakdownSection extends StatelessWidget {
  const PaydayBreakdownSection({
    super.key,
    required this.monthlyIncome,
    required this.bills,
    required this.billsCount,
    required this.safeToSpend,
    required this.isLoading,
  });

  final double monthlyIncome;
  final double bills;
  final int billsCount;
  final double safeToSpend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Payday Breakdown',
          style: getRegularStyle16_500(
            fontSize: 16.sp,
            color: ColorManager.cB8976A,
          ),
        ),
        SizedBox(height: 32.h),
        BreakdownRow(
          label: 'Pay this period',
          value: '\$${monthlyIncome.toStringAsFixed(0)}',
        ),
        SizedBox(height: 16.h),
        BreakdownRow(
          label: 'Bills ($billsCount)',
          value: '\$${bills.toStringAsFixed(0)}',
        ),
        SizedBox(height: 20.h),
        Divider(color: ColorManager.cE0D4C2, thickness: 1),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Safe to Spend',
              style: getMediumStyle18(color: ColorManager.c3B2208),
            ),
            Text(
              isLoading ? '...' : '\$${safeToSpend.toStringAsFixed(0)}',
              style: getMediumStyle18(color: ColorManager.textPrimary),
            ),
          ],
        ),
      ],
    );
  }
}
