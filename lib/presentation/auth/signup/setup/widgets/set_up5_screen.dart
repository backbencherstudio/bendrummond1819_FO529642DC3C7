import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/set_up6_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../widgets/custom_from_field.dart';

class SetUp5Screen extends ConsumerStatefulWidget {
  const SetUp5Screen({super.key});

  @override
  ConsumerState<SetUp5Screen> createState() => _SetUp5ScreenState();
}

class _SetUp5ScreenState extends ConsumerState<SetUp5Screen> {
  bool isChecked = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Title ---
              Text(
                "Any car payment?",
                style: getSemiBoldStyle32(color: ColorManager.textPrimary),
              ),
               SizedBox(height: 15.h),

              // --- Subtitle ---
              Text(
                "Monthly car loan or lease amount.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),

              SizedBox(height: 24.h),

              CustomFromField(
                hintText: "1400",
                prefixIcon: SvgPicture.asset(IconManager.dollar),
                controller: _amountController,
              ),
              SizedBox(height: 16.h),

              // --- Checkbox Row ---
              GestureDetector(
                onTap: () => setState(() => isChecked = !isChecked),
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: ColorManager.brown400.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: isChecked
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
                      style: getRegularStyle14_400(color: ColorManager.brown),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
