import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalancesScreen extends StatefulWidget {
  const BalancesScreen({super.key});

  @override
  State<BalancesScreen> createState() => _BalancesScreenState();
}

class _BalancesScreenState extends State<BalancesScreen> {
  // Color Palette
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color cardBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              // Header
              Text(
                'Balances',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              SizedBox(height: 30.h),

              // Credit Card Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ColorManager.background,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.08),
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
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontSerif,
                              color: darkBrown.withValues(alpha: 0.8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Due day 6',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: fontSerif,
                              color: mutedBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$25',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontSerif,
                        color: mutedBrown,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Icon(Icons.close, color: darkBrown, size: 24),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Add a debt payment (Dashed Border)
              CustomPaint(
                painter: DashedRectPainter(color: mutedBrown),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      // Plus Icon Button
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBE5D8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: darkBrown, size: 20),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Add a debt payment',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: fontSerif,
                          color: mutedBrown,
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
