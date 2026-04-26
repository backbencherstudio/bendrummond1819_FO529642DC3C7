import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup3/view/set_up3_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUp2Screen extends ConsumerStatefulWidget {
  const SetUp2Screen({super.key});

  @override
  ConsumerState<SetUp2Screen> createState() => _SetUp2ScreenState();
}

class _SetUp2ScreenState extends ConsumerState<SetUp2Screen> {
  int _selectedIndex = 0;

  final List<String> _payFrequencies = [
    "Weekly",
    "Every 2 weeks",
    "Twice a month",
    "Monthly",
    "It's inconsistent",
  ];

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
                    // --- Header Row (Progress 2 of 8) ---
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

                    // --- Title ---
                    Text(
                      "How often do you usually get paid?",
                      style: getBoldStyle24(
                        color: ColorManager.textPrimary,
                        fontSize: 32.sp,
                      ).copyWith(height: 1.2, fontFamily: 'serif'),
                    ),
                    SizedBox(height: 32.h),

                    // --- Frequency Options List ---
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _payFrequencies.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        return _buildFrequencyCard(
                          index: index,
                          label: _payFrequencies[index],
                          isSelected: _selectedIndex == index,
                        );
                      },
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
                      builder: (context) => const SetUp3Screen(),
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

  Widget _buildFrequencyCard({
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        decoration: BoxDecoration(
          // Use a light fill color for unselected, or transparent
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : const Color(0xFFFDFBF7),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.textPrimary
                : const Color(0xFFE5E1D9),
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: getBoldStyle24(
                color: ColorManager.textPrimary,
                fontSize: 20.sp,
              ).copyWith(fontFamily: 'serif', fontWeight: FontWeight.w500),
            ),
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }
}
