import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/image_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageSectionHeight = screenHeight * 0.58;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                      child: customLogoText(),
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
                    ).copyWith(letterSpacing: -0.5),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "See what money comes in and goes out. Know what's actually safe to spend.",
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),

                  SizedBox(height: 25.h),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 12.h,
                    children: [
                      _buildFeatureRow("2-Minute Setup"),
                      _buildFeatureRow("One Question at a Time"),
                      _buildFeatureRow("Really simple"),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  /// ************ Get Started Button *****************
                  PrimaryButton(title: "Get Started", onTap: () {}),

                  SizedBox(height: 12.h),

                  /// ************ Sign in Button *****************
                  CustomOutlinedButton(
                    title: "Sign in to your account",
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signInRoute);
                    },
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
          width: 8.w,
          height: 8.h,
          decoration: const BoxDecoration(
            gradient: ColorManager.linearGradientColor2,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.w),
        Text(text, style: getLightStyle12_400(color: ColorManager.brown300)),
      ],
    );
  }
}
