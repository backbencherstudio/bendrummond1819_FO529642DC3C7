import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/pay/viewmodel/pay_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resource/constants/icon_manager.dart';

class PayScreen extends ConsumerStatefulWidget {
  const PayScreen({super.key});

  @override
  ConsumerState<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends ConsumerState<PayScreen> {
  @override
  Widget build(BuildContext context) {
    final isSchedule = ref.watch(payScheduleProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========= Header Section ==========
              Text(
                'Pay & Income',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 24.h),

              // ======= Safe to spend Card =========
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorManager.backgroundPressed100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Safe to spend',
                          style: getRegularStyle16_400(
                            color: ColorManager.brown300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          '\$185',
                          style: getMediumStyle18(
                            color: ColorManager.textPrimary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        'Updates when you save',
                        textAlign: TextAlign.right,
                        style: getRegularStyle16_400(
                          color: ColorManager.brown300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // ========= Pay schedule section =========
              _buildLabel('Pay schedule'),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 4,
                runSpacing: 6,
                children: [
                  _buildChip('Weekly', isSchedule),
                  _buildChip('Every 2 weeks', isSchedule),
                  _buildChip('Monthly', isSchedule),
                  _buildChip('Twice a month', isSchedule),
                  _buildChip('It\'s inconsistent', isSchedule),
                ],
              ),
              SizedBox(height: 12.h),

              // ======== One paycheck amount ==========
              _buildLabel('One paycheck amount'),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '1400',
                prefixIcon: SvgPicture.asset(IconManager.dollar),
              ),
              SizedBox(height: 12.h),

              // ======== Rent / mortgage ============
              _buildLabel('Rent / mortgage (monthly)'),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '60',
                prefixIcon: SvgPicture.asset(IconManager.dollar),
              ),

              SizedBox(height: 80.h),

              // ========== Save Changes Button ======
              PrimaryButton(
                title: 'Save changes',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.chooseYourPlainScreen,
                  );
                },
              ),
              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }

  // ======= Helper widget for Labels ========
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300),
    );
  }

  // ===== Helper widget for Schedule Chips ======
  Widget _buildChip(String label, String activeLabel) {
    final bool isActive = label == activeLabel;
    return InkWell(
      onTap: () {
        ref.read(payScheduleProvider.notifier).schedule(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? ColorManager.textPrimary : Colors.white,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isActive
                ? ColorManager.textPrimary
                : ColorManager.borderE0D9D1,
          ),
        ),
        child: Text(
          label,
          style: getRegularStyle16_400(
            color: isActive ? ColorManager.whiteColor : ColorManager.brown400,
          ),
        ),
      ),
    );
  }
}
