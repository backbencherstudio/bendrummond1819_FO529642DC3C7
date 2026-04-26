import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/image_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageSectionHeight = screenHeight * 0.58;

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: imageSectionHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      ImageManager.onBoardingImg,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w, top: 20.h),
                      child: Text(
                        "STABILITY",
                        style: getRegularStyle16_400(
                          fontSize: 20.sp,
                          color: ColorManager.brown500,
                        ).copyWith(letterSpacing: 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              color: ColorManager.secondary,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),

                  Text(
                    "Win back confidence over spending.",
                    style: getBoldStyle24(
                      fontSize: 28.sp,
                      color: ColorManager.brown,
                    ).copyWith(height: 1.1, letterSpacing: -0.5),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "See what money comes in and goes out. Know what's actually safe to spend.",
                    style: getRegularStyle16_400(
                      color: ColorManager.whiteColor,
                    ),
                  ),

                  SizedBox(height: 25.h),

                  _buildFeatureRow("2-Minute Setup"),
                  SizedBox(height: 10.h),
                  _buildFeatureRow("One Question at a Time"),
                  SizedBox(height: 10.h),
                  _buildFeatureRow("Really simple"),

                  SizedBox(height: 50.h),

                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryButton,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Get Started",
                        style: getMediumStyle18(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: ColorManager.customOutlineButtonBorder,
                        ),
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Sign in to your account",
                        style: getMediumStyle18(
                          fontSize: 16.sp,
                          color: ColorManager.brown500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5.r,
          height: 5.r,
          decoration: const BoxDecoration(
            color: Color(0xFFA07848),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          text,
          style: getRegularStyle16_400(
            fontSize: 14.sp,
            color: ColorManager.subtitleText.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
