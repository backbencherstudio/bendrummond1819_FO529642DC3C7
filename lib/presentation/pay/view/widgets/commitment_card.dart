import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommitmentCard extends StatelessWidget {
  final FinancialCommitmentData commitment;

  const CommitmentCard({super.key, required this.commitment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
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
                  commitment.name,
                  style: getRegularStyle16_400(
                    color: ColorManager.brown400,
                    fontSize: 18,
                  ),
                ),
                if (commitment.dueDay != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Due day ${commitment.dueDay}',
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
            '\$${commitment.amount.toStringAsFixed(0)}',
            style: getRegularStyle16_400(
              color: ColorManager.brown400,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
