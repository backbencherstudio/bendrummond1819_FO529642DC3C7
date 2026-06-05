import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetUp3Screen extends ConsumerStatefulWidget {
  const SetUp3Screen({super.key});

  @override
  ConsumerState<SetUp3Screen> createState() => _SetUp3ScreenState();
}

class _SetUp3ScreenState extends ConsumerState<SetUp3Screen> {
  late final TextEditingController _amountController;
  late bool _isRecurring;

  @override
  void initState() {
    super.initState();
    final data = ref.read(setupDataProvider);
    _amountController = TextEditingController(text: data.baseIncome);
    _isRecurring = data.isRecurringIncome;
    _amountController.addListener(() {
      ref.read(setupDataProvider.notifier).setBaseIncome(_amountController.text);
    });
  }

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
                    // --- Title Section ---
                    Text(
                      "About how much do you bring in?",
                      style: getSemiBoldStyle32(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Choose the lower end.",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // --- Custom Amount Input Field ---
                    CustomFromField(
                      hintText: "1400",
                      prefixIcon: SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: SvgPicture.asset(
                          IconManager.dollar,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      controller: _amountController,
                    ),

                    SizedBox(height: 16.h),

                    // --- Custom Checkbox Row ---
                    GestureDetector(
                      onTap: () {
                        setState(() => _isRecurring = !_isRecurring);
                        ref.read(setupDataProvider.notifier).setIsRecurringIncome(_isRecurring);
                      },
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
                            style: getRegularStyle14_400(
                              color: ColorManager.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
