import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/viewmodel/choose_plan_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChooseYourPlanScreen extends ConsumerStatefulWidget {
  const ChooseYourPlanScreen({super.key});

  @override
  ConsumerState<ChooseYourPlanScreen> createState() =>
      _ChooseYourPlanScreenState();
}

class _ChooseYourPlanScreenState extends ConsumerState<ChooseYourPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final isMonthlyState = ref.watch(planToggleProvider);
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 32.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =============== Header Section ==================
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customBackButton(
                    context,
                    color: ColorManager.borderColor,
                    borderColor: ColorManager.borderColor3,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Choose Your Plan',
                    style: getSemiBoldStyle22(
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // =========== First Text Section =================
              Text(
                "Start knowing what's safe to spend.",
                style: getBoldStyle32(
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              // =========== Second Text Section =================
              Text(
                "Full access to Stability. Cancel anytime.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              // ============= Toggle Switch Section =============
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // monthly yearly toggle
                    _buildToggleSwitch(isMonthlyState),
                    Positioned(
                      right: -50.5.w,
                      top: -8.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.goldAccent,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        // best value tag
                        child: Text(
                          'Best Value',
                          style: getLightStyle12_400(
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ============== Plan Details Card =============
              _buildPlanCard(isMonthlyState),
              SizedBox(height: 40.h),
              // =============== Primary Button ===============
              PrimaryButton(
                title: 'Start my Plan',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.completePaymentScreen,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== Toggle Button Section ================
  Widget _buildToggleSwitch(bool isMonthly) {
    return Container(
      width: 220.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEFE9DE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _toggleItem(
            "Monthly",
            isMonthly,
            () => ref.read(planToggleProvider.notifier).toggle(true),
          ),
          _toggleItem(
            "Yearly",
            !isMonthly,
            () => ref.read(planToggleProvider.notifier).toggle(false),
          ),
        ],
      ),
    );
  }

  Widget _toggleItem(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isActive
                ? ColorManager.textPrimary
                : ColorManager.transparentColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: getLightStyle14_400(
              color: isActive
                  ? ColorManager.whiteColor
                  : ColorManager.grayBlack400,
            ),
          ),
        ),
      ),
    );
  }

  // ============= Monthly Yearly Card Plain ==============
  Widget _buildPlanCard(bool isMonthly) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.backgroundPressed100,
          width: 1.5.w,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMonthly ? 'Monthly' : 'Yearly',
                    style: getBoldStyle24(
                      color: ColorManager.grayBlack400,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    isMonthly ? 'Billed every month' : 'Billed every year',
                    style: getRegularStyle16_400(color: ColorManager.grayBlack400),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isMonthly ? '\$3.99' : '\$39.99',
                    style: getBoldStyle32(
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    isMonthly ? '/month' : '/year',
                    style: getRegularStyle14_400(
                      color: ColorManager.grayBlack400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildFeatureRow("Unlimited Safe to Spend calculations"),
          _buildFeatureRow("Bills, goals & debt tracking"),
          _buildFeatureRow("Real-time recalculation"),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Row(
        children: [
          SvgPicture.asset(IconManager.correct, width: 16.w, height: 16.h),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: getRegularStyle16_400(color: ColorManager.grayBlack400),
            ),
          ),
        ],
      ),
    );
  }
}
