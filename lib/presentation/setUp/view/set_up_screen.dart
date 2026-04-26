import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup2/view/set_up2_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart'; // Assuming you have this
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../viewmodel/set_up_screen_riverpod.dart';

class SetUpScreen extends ConsumerStatefulWidget {
  const SetUpScreen({super.key});

  @override
  ConsumerState<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends ConsumerState<SetUpScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _options = [
    {
      "title": "Same every paycheck",
      "subtitle": "Salary, hourly with set schedule",
      "icon": Icons.trending_up_rounded,
    },
    {
      "title": "Varies a little",
      "subtitle": "Close but not exact each time",
      "icon": Icons.bar_chart_rounded,
    },
    {
      "title": "Varies a lot",
      "subtitle": "Gig work, tips, commissions",
      "icon": Icons.shuffle_rounded,
    },
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
                    // ========== Header Section ============
                    Row(
                      children: [
                        customBackButton(
                          context,
                          onPressed: () {
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
                      "How does your income usually come in?",
                      style: getRegularStyle16_600(
                        color: ColorManager.textPrimary,
                        fontSize: 32.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "This helps set realistic expectations.",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // --- Selection Options ---
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _options.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return _buildOptionCard(
                          index: index,
                          title: _options[index]['title'],
                          subtitle: _options[index]['subtitle'],
                          icon: _options[index]['icon'],
                          isSelected: _selectedIndex == index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // --- Fixed Bottom Button ---
            Padding(
              padding: EdgeInsets.all(24.w),
              child: PrimaryButton(
                title: "Continue",
                onTap: () {
                  notifier.nextStep();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetUp2Screen(),
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

  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.textPrimary
                : const Color(0xFFE5E1D9),
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            // Icon Circle
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFE9DE),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: ColorManager.textPrimary, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldStyle24(
                      color: ColorManager.textPrimary,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Checkmark
            if (isSelected)
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: ColorManager.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 14.sp),
              ),
          ],
        ),
      ),
    );
  }
}
