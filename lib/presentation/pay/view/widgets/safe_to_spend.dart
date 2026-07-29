import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafeToSpendCard extends StatelessWidget {
  final double safeToSpend;

  const SafeToSpendCard({super.key, required this.safeToSpend});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.backgroundPressed100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Safe to spend',
                style: getRegularStyle16_400(
                  color: ColorManager.brown300,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                '\$${safeToSpend.toStringAsFixed(0)}',
                style: getMediumStyle18(
                  color: ColorManager.textPrimary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              'Updates when you save',
              textAlign: TextAlign.right,
              style: getRegularStyle16_400(
                color: ColorManager.brown300,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
