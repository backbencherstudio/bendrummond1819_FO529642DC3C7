import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup4/view/set_up4_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUp3Screen extends ConsumerStatefulWidget {
  const SetUp3Screen({super.key});

  @override
  ConsumerState<SetUp3Screen> createState() => _SetUp3ScreenState();
}

class _SetUp3ScreenState extends ConsumerState<SetUp3Screen> {
  final TextEditingController _amountController = TextEditingController(
    text: "1400",
  );
  bool _isRecurring = false;

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(setupStepProvider);
    final notifier = ref.read(setupStepProvider.notifier);

    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Row (Progress 3 of 8) ---
                    Row(
                      children: [
                        customBackButton(
                          context,
                          onPressed: () {
                            notifier.previousStep();
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$currentStep of $totalSteps",
                                style: getRegularStyle16_400(
                                  color: ColorManager.brown400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(99.r),
                                child: LinearProgressIndicator(
                                  minHeight: 6.h,
                                  backgroundColor: const Color(0xFFE5E1D9),
                                  value: currentStep / totalSteps,
                                  valueColor: AlwaysStoppedAnimation(
                                    ColorManager.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // --- Title Section ---
                    Text(
                      "About how much do\nyou bring in?",
                      style: getBoldStyle24(
                        color: ColorManager.textPrimary,
                        fontSize: 32.sp,
                      ).copyWith(height: 1.2, fontFamily: 'serif'),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Choose the lower end.",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // --- Custom Amount Input Field ---
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDFBF7),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFFE5E1D9)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "\$",
                            style: getRegularStyle16_400(
                              color: ColorManager.textPrimary,
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              style: getBoldStyle24(
                                color: ColorManager.textPrimary,
                                fontSize: 22.sp,
                              ).copyWith(fontWeight: FontWeight.w500),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // --- Custom Checkbox Row ---
                    GestureDetector(
                      onTap: () => setState(() => _isRecurring = !_isRecurring),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: ColorManager.brown400.withValues(
                                  alpha: 0.5,
                                ),
                                width: 1.5,
                              ),
                            ),
                            child: _isRecurring
                                ? Icon(
                                    Icons.check,
                                    size: 14.sp,
                                    color: ColorManager.textPrimary,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Set as Weekly/Monthly Payment",
                            style: getRegularStyle16_400(
                              color: ColorManager.brown400,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Continue Button ---
            Padding(
              padding: EdgeInsets.all(24.w),
              child: PrimaryButton(
                title: "Continue",
                onTap: () {
                  notifier.nextStep();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetUp4Screen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
