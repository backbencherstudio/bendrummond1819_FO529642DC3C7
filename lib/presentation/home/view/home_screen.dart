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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                        style: getRegularStyle16_400(
                          fontSize: 14,
                          color: ColorManager.cA87B4D,
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesName.homeSettingsScreen,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: ColorManager.secondaryBackGround,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        IconManager.userIcon,
                        colorFilter: ColorFilter.mode(
                          ColorManager.primaryButton,
                          BlendMode.srcIn,
                        ),
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

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
                        '\$185',
                        style: getMediumStyle18(
                          fontSize: 100,
                          color: ColorManager.c2E1606,
                        ),
                      ),

                      // Divider with Text
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
                              'October 1st paycheck',
                              style: getLightStyle14_400(
                                color: ColorManager.cA27E5D,
                              ),
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
              ),

              SizedBox(height: 32.h),

              // --- Payday Breakdown Section ---
              Text(
                'Payday Breakdown',
                style: getRegularStyle16_500(
                  fontSize: 16.sp,
                  color: ColorManager.cB8976A,
                ),
              ),
              SizedBox(height: 32.h),

              _buildBreakdownRow("Pay going to bills", "\$1,350"),
              SizedBox(height: 16.h),
              _buildBreakdownRow("Bills (2)", "\$865"),

              SizedBox(height: 20.h),
              Divider(color: ColorManager.cE0D4C2, thickness: 1),
              SizedBox(height: 10.h),

              // Total Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Safe to Spend',
                    style: getMediumStyle18(color: ColorManager.c3B2208),
                  ),
                  Text(
                    '\$185',
                    style: getMediumStyle18(color: ColorManager.textPrimary),
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
        Text(label, style: getRegularStyle16_400(color: ColorManager.cA08060)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: CustomPaint(painter: DottedLinePainter()),
          ),
        ),
        Text(value, style: getRegularStyle16_400(color: ColorManager.c7A5E38)),
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
      ..color = ColorManager.cA08060
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
