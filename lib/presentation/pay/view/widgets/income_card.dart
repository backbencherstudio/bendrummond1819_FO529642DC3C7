import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/income_constants.dart';

/// A single income row shown on the Pay & Income screen. Tapping it opens
/// the add/edit sheet in edit mode.
class IncomeCard extends StatelessWidget {
  final IncomeData income;
  final VoidCallback onTap;

  const IncomeCard({super.key, required this.income, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorManager.secondaryBackGround,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.borderE0D9D1, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatEnumLabel(income.incomeType),
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    formatEnumLabel(income.payFrequency),
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${income.baseIncome.toStringAsFixed(0)}',
              style: getRegularStyle16_400(
                color: ColorManager.brown400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
