import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebtCard extends StatelessWidget {
  final FinancialCommitmentData debt;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const DebtCard({
    super.key,
    required this.debt,
    required this.onTap,
    required this.onDelete,
  });

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
                    debt.name,
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 18,
                    ),
                  ),
                  if (debt.dueDay != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Due day ${debt.dueDay}',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              '\$${debt.amount.toStringAsFixed(0)}',
              style: getRegularStyle16_400(
                color: ColorManager.brown400,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 18.w),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.close,
                color: ColorManager.primaryButton,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
