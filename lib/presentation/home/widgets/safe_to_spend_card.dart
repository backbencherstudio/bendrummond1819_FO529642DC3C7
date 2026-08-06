import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafeToSpendCard extends StatelessWidget {
  const SafeToSpendCard({
    super.key,
    required this.safeToSpend,
    required this.payFrequencyLabel,
    required this.isLoading,
  });

  final double safeToSpend;
  final String payFrequencyLabel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(0.0015, 0.0),
              radius: 0.5,
              colors: [
                ColorManager.cE9D6A5,
                ColorManager.cEADFC6,
                ColorManager.primaryLight,
              ],
              stops: const [0.0, 0.3648, 0.9737],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'SAFE TO SPEND',
              style: getLightStyle14_400(
                fontSize: 11,
                color: ColorManager.gold,
              ).copyWith(letterSpacing: 1.5),
            ),
            Text(
              textAlign: TextAlign.center,
              isLoading ? '...' : '\$${safeToSpend.toStringAsFixed(0)}',
              style: getMediumStyle18(
                color: ColorManager.c2E1606,
                fontSize: 40,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32.w,
                  height: 1.h,
                  color: ColorManager.cACA49F,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    payFrequencyLabel,
                    style: getLightStyle14_400(color: ColorManager.cA27E5D),
                  ),
                ),
                Container(
                  width: 32.w,
                  height: 1.h,
                  color: ColorManager.cACA49F,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
