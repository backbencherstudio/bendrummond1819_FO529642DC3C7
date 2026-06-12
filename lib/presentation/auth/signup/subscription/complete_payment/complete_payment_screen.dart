import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/viewmodel/choose_plan_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/subscription_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletePaymentScreen extends ConsumerStatefulWidget {
  const CompletePaymentScreen({super.key});

  @override
  ConsumerState<CompletePaymentScreen> createState() =>
      _CompletePaymentScreenState();
}

class _CompletePaymentScreenState
    extends ConsumerState<CompletePaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionProvider.notifier).loadOfferings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMonthly = ref.watch(planToggleProvider);
    final subState = ref.watch(subscriptionProvider);
    final package = isMonthly
        ? subState.offerings?.current?.monthly
        : subState.offerings?.current?.annual;
    final price = package?.storeProduct.priceString ?? '';
    final period = isMonthly ? '/month' : '/year';

    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
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
                          'Complete Payment',
                          style: getSemiBoldStyle22(
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: ColorManager.backgroundSecondary,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorManager.backgroundPressed100,
                          width: 1.5.w,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            isMonthly ? 'Monthly Plan' : 'Yearly Plan',
                            style: getSemiBoldStyle22(
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            price,
                            style: getBoldStyle32(
                              color: ColorManager.textPrimary,
                              fontSize: 48.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            period,
                            style: getRegularStyle14_400(
                              color: ColorManager.grayBlack400,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Full access to Stability. Cancel anytime.",
                            style: getRegularStyle16_400(
                              color: ColorManager.brown400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "You will be charged via your App Store / Google Play account. "
                      "Payment will be handled securely by Apple or Google.",
                      style: getLightStyle14_400(color: ColorManager.brown300),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (subState.error != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        subState.error!,
                        style: getLightStyle14_400(
                            color: ColorManager.redColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  PrimaryButton(
                    title: subState.isLoading
                        ? 'Processing...'
                        : 'Pay $price$period',
                    onTap: subState.isLoading || package == null
                        ? null
                        : () async {
                            final success = await ref
                                .read(subscriptionProvider.notifier)
                                .purchase(package);
                            if (success && mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesName.resultScreen,
                                (route) => false,
                              );
                            }
                          },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "You'll receive a digital invoice to your mail after successful payment",
                    textAlign: TextAlign.center,
                    style: getLightStyle14_500(
                      color: ColorManager.grayBlack400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
