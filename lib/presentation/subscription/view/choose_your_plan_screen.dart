import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/subscription/viewmodel/choose_plan_riverpod.dart';
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
  bool isMonthly = true;

  // Custom Colors from the image
  final Color backgroundColor = const Color(0xFFFBF7EF);
  final Color primaryDark = const Color(0xFF4D3D33);
  final Color accentGold = const Color(0xFFD4C18E);
  final Color cardBorderColor = const Color(0xFFE5E1D9);

  @override
  Widget build(BuildContext context) {
    final isMonthlyState = ref.watch(planToggleProvider);
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =============== Header Section ==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customBackButton(context),
                    SizedBox(width: 12.w),
                    Text(
                      'Choose Your Plan',
                      style: getBoldStyle24(
                        color: ColorManager.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // =========== First Text Section =================
                Text(
                  "Start knowing what's safe to spend.",
                  style: getRegularStyle16_600(
                    color: ColorManager.textPrimary,
                    fontSize: 32.sp,
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
                SizedBox(height: 20.h),

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
            color: isActive ? primaryDark : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: getLightStyle14_400(
              color: isActive ? ColorManager.whiteColor : ColorManager.black400,
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
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xFFDFE1E7),
          width: 2.w,
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
                    style: getRegularStyle16_600(
                      fontSize: 32.sp,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    isMonthly ? 'Billed every month' : 'Billed every year',
                    style: getRegularStyle16_400(color: ColorManager.black300),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isMonthly ? '\$3.99' : '\$39.99',
                    style: getRegularStyle16_600(
                      fontSize: 32.sp,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    isMonthly ? '/month' : '/year',
                    style: getRegularStyle16_400(color: ColorManager.black400),
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
              style: getRegularStyle16_400(color: ColorManager.black500),
            ),
          ),
        ],
      ),
    );
  }
}
