import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Color Palette
  final Color bgColor = ColorManager.background;
  //final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),

              // =========== Header Section ===========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLogoText(),
                      Text(
                        'Good evening, Yasir',
                        style:
                            getRegularStyle16_400(
                              fontSize: 16,
                              color: ColorManager.gold,
                            ).copyWith(
                             
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesName.homeSettingsScreen,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.brown300.withValues(alpha: 0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: ColorManager.whiteColor,
                        child: SvgPicture.asset(IconManager.userIcon),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 60.h),

              // --- Main "Safe to Spend" Section with Glow ---
              Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle Radial Glow
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
                          ColorManager.background,
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
                          fontWeight: FontWeight.w500,
                        ).copyWith(letterSpacing: 1.5),
                      ),
                      Text(
                        '\$185',
                        style: getLightStyle14_400(
                          fontSize: 100,

                          fontWeight: FontWeight.bold,
                          color: ColorManager.backgroundDark.withValues(
                            alpha: 0.9,
                          ),
                        ),
                      ),

                      // Divider with Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.w,
                            height: 1.h,
                            color: ColorManager.gold,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              'October 1st paycheck',
                              style: getLightStyle14_400(
                                color: ColorManager.gold,
                              ),
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 1.h,
                            color: ColorManager.gold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 100.h),

              // --- Payday Breakdown Section ---
              Text(
                'Payday Breakdown',
                style: getRegularStyle16_500(
                  fontSize: 18.sp,
                  color: const Color(0xFFA67C52),
                ),
              ),
              SizedBox(height: 30.h),

              _buildBreakdownRow("Pay going to bills", "\$1,350"),
              SizedBox(height: 15.h),
              _buildBreakdownRow("Bills (2)", "\$865"),

              SizedBox(height: 15.h),
              Divider(
                color: ColorManager.gold.withValues(alpha: 0.3),
                thickness: 1,
              ),
              SizedBox(height: 10.h),

              // Total Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Safe to Spend',
                    style: getMediumStyle18(
                      fontWeight: FontWeight.bold,
                      color: ColorManager.backgroundDark,
                    ),
                  ),
                  Text(
                    '\$185',
                    style: getMediumStyle18(
                      fontWeight: FontWeight.bold,
                      color: ColorManager.backgroundDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120.h), // Padding for Bottom Nav
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Dotted Breakdown Rows
  Widget _buildBreakdownRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: getRegularStyle16_400(
            color: ColorManager.gold,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: CustomPaint(painter: DottedLinePainter()),
          ),
        ),
        Text(
          value,
          style: getRegularStyle16_400(
            color: ColorManager.gold,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for the Dotted Line effect
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 1.2),
        Offset(startX + dashWidth, size.height / 1.2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
