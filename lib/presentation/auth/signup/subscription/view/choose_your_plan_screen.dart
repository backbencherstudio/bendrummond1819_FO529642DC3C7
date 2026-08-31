import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/viewmodel/choose_plan_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/widgets/plan_billing_toggle.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/widgets/plan_card.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/widgets/plan_error_banner.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/widgets/terms_of_service.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/subscription_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final monthlyPackage = subState.offerings?.current?.monthly?.storeProduct;
    final yearlyPackage = subState.offerings?.current?.annual?.storeProduct;
    final canPurchase =
        !subState.isLoading &&
        subState.error == null &&
        subState.offerings?.current != null;

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
                    style: getSemiBoldStyle22(color: ColorManager.textPrimary),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "Start knowing what's safe to spend.",
                style: getBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 16.h),
              Text(
                "Full access to Stability. Cancel anytime.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),
              PlanBillingToggle(
                isMonthly: isMonthlyState,
                onChanged: (isMonthly) =>
                    ref.read(planToggleProvider.notifier).toggle(isMonthly),
              ),
              SizedBox(height: 24.h),
              PlanCard(
                isMonthly: isMonthlyState,
                monthlyPrice: monthlyPackage?.priceString,
                yearlyPrice: yearlyPackage?.priceString,
                isLoading: subState.isLoading,
                features: [
                  'Unlimited Safe to Spend calculations',
                  'Bills, goals & debt tracking',
                  'Real-time recalculation',
                ],
              ),
              SizedBox(height: 40.h),
              if (subState.error != null) ...[
                PlanErrorBanner(
                  message: subState.error!,
                  onRetry: () =>
                      ref.read(subscriptionProvider.notifier).loadOfferings(),
                ),
                SizedBox(height: 12.h),
              ],
              PrimaryButton(
                title: subState.isLoading ? 'Loading...' : 'Start my Plan',
                onTap: canPurchase
                    ? () {
                        final package = isMonthlyState
                            ? subState.offerings!.current!.monthly
                            : subState.offerings!.current!.annual;
                        if (package == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'This plan is not available. Please try a different plan.',
                              ),
                            ),
                          );
                          return;
                        }
                        Navigator.pushNamed(
                          context,
                          RoutesName.completePaymentScreen,
                        );
                      }
                    : null,
              ),
              TermsOfService(),
            ],
          ),
        ),
      ),
    );
  }
}

