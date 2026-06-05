import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUp2Screen extends ConsumerStatefulWidget {
  const SetUp2Screen({super.key});

  @override
  ConsumerState<SetUp2Screen> createState() => _SetUp2ScreenState();
}

class _SetUp2ScreenState extends ConsumerState<SetUp2Screen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ref.read(setupDataProvider).payFrequencyIndex;
  }

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
      onTap: () {
        setState(() => _selectedIndex = index);
        ref.read(setupDataProvider.notifier).setPayFrequencyIndex(index);
      },
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
            Icon(Icons.check_circle, color: ColorManager.textPrimary),
          ],
        ),
      ),
    );
  }
}
