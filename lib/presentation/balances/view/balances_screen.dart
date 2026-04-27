import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalancesScreen extends StatefulWidget {
  const BalancesScreen({super.key});

  @override
  State<BalancesScreen> createState() => _BalancesScreenState();
}

class _BalancesScreenState extends State<BalancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Balances',
                style: getSemiBoldStyle22(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 24.h),

              // Credit Card Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ColorManager.secondaryBackGround,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: ColorManager.borderE0D9D1,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Credit card',
                            style: getRegularStyle16_400(
                              color: ColorManager.brown400,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Due day 6',
                            style: getRegularStyle16_400(
                              color: ColorManager.brown400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$25',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Icon(
                      Icons.close,
                      color: ColorManager.primaryButton,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Add a debt payment (Dashed Border)
              CustomPaint(
                painter: DashedRectPainter(color: ColorManager.primaryButton),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      // Plus Icon Button
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: ColorManager.backgroundCard,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: ColorManager.primaryButton,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Add a debt payment',
                        style: getRegularStyle16_400(
                          color: ColorManager.brown400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter to create the dashed border effect
class DashedRectPainter extends CustomPainter {
  final Color color;
  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var path = Path();
    // Round rectangle path
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ),
    );

    // Draw dashed effect
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (startX < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(startX, startX + dashWidth),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
