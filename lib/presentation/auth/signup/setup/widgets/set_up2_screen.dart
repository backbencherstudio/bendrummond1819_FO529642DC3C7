import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/set_up3_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/set_up_screen_riverpod.dart';
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
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // --- Title ---
                    Text(
                      "How often do you usually get paid?",
                      style: getSemiBoldStyle32(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 24.h),

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
          color: isSelected
              ? ColorManager.backgroundSecondary
              : ColorManager.backgroundSecondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.textPrimary
                : ColorManager.backgroundPressed100,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isSelected ? Text(
              label,
              style: getRegularStyle20_600(
                color: ColorManager.textPrimary,
              ),
            ) : Text(
              label,
              style: getRegularStyle20_600(
                color: ColorManager.grayBlack400,
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  color: ColorManager.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 10.sp),
              ),
          ],
        ),
      ),
    );
  }
}
