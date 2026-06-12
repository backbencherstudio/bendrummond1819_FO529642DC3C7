import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/viewmodel/choose_plan_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/subscription_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class ChooseYourPlanScreen extends ConsumerStatefulWidget {
  const ChooseYourPlanScreen({super.key});

  @override
  ConsumerState<ChooseYourPlanScreen> createState() =>
      _ChooseYourPlanScreenState();
}

class _ChooseYourPlanScreenState extends ConsumerState<ChooseYourPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionProvider.notifier).loadOfferings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMonthlyState = ref.watch(planToggleProvider);
    final subState = ref.watch(subscriptionProvider);
    final monthlyPackage =
        subState.offerings?.current?.monthly?.storeProduct;
    final yearlyPackage =
        subState.offerings?.current?.annual?.storeProduct;

    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                "Start knowing what's safe to spend.",
                style: getBoldStyle32(
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Full access to Stability. Cancel anytime.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
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
              _buildPlanCard(
                isMonthlyState,
                monthlyPackage,
                yearlyPackage,
                subState.isLoading,
              ),
              SizedBox(height: 40.h),
              if (subState.error != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    subState.error!,
                    style: getLightStyle14_400(color: ColorManager.redColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              PrimaryButton(
                title: subState.isLoading ? 'Loading...' : 'Start my Plan',
                onTap: subState.isLoading
                    ? null
                    : () {
                        final package = isMonthlyState
                            ? subState.offerings?.current?.monthly
                            : subState.offerings?.current?.annual;
                        if (package == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No products available. Please try again.')),
                          );
                          return;
                        }
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

  Widget _buildPlanCard(
    bool isMonthly,
    StoreProduct? monthlyProduct,
    StoreProduct? yearlyProduct,
    bool isLoading,
  ) {
    final price = isMonthly
        ? (monthlyProduct?.priceString ?? '\$3.99')
        : (yearlyProduct?.priceString ?? '\$39.99');
    final period = isMonthly ? '/month' : '/year';
    final label = isMonthly ? 'Billed every month' : 'Billed every year';

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
                    label,
                    style: getRegularStyle16_400(
                        color: ColorManager.grayBlack400),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isLoading ? '...' : price,
                    style: getBoldStyle32(
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    period,
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
