import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillCard extends StatelessWidget {
  final FinancialCommitmentData bill;
  final String subtitle;
  final VoidCallback onEditTap;

  const BillCard({
    super.key,
    required this.bill,
    required this.subtitle,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.borderE0D9D1, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill.name,
                  style: getMediumStyle18(color: ColorManager.brown500),
                ),
                SizedBox(height: 12.h),
                Text(
                  subtitle,
                  style: getRegularStyle16_400(
                    color: ColorManager.grayBlack400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$${bill.amount.toStringAsFixed(0)}",
                style: getMediumStyle18(color: ColorManager.textPrimary),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: onEditTap,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorManager.backgroundCard,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    IconManager.editIcon,
                    width: 16.sp,
                    height: 16.sp,
                    colorFilter: ColorFilter.mode(
                      ColorManager.primaryButton,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
