import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/constants/icon_manager.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  bool _isRecurring = false;
  int _selectedFrequency = 0; // 0: Beginning, 1: Middle, 2: End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Back Button + Title
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Add bill',
                    style: getSemiBoldStyle22(
                      color: ColorManager.textPrimary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              _buildLabel("Bill Name"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: "Electricity Bill"),

              SizedBox(height: 12.h),

              _buildLabel("Amount"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '60',
                prefixIcon: SvgPicture.asset(IconManager.dollar),
              ),

              SizedBox(height: 6.h),

              // Checkbox Row
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _isRecurring,
                      activeColor: ColorManager.brown,
                      side: BorderSide(color: ColorManager.brown, width: 1.5),
                      onChanged: (val) => setState(() => _isRecurring = val!),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Set as Weekly/Monthly Payment",
                    style: getRegularStyle16_400(
                      color: ColorManager.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),
              _buildLabel("Frequency"),
              SizedBox(height: 6.h),

              // Frequency Selection Cards
              _buildFrequencyCard(0, "Beginning of month", "1st - 10th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(1, "Middle of month", "11th - 20th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(2, "End of month", "21st - 31st"),

              SizedBox(height: 6.h),

              // Custom Date Dropdown
              _buildCustomDateDropdown(),

              SizedBox(height: 12.h),
              _buildLabel("Due day"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: "4 "),

              SizedBox(height: 24.h),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(title: "Delete", onTap: () {}),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: PrimaryButton(title: "Add Bill", onTap: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  Widget _buildFrequencyCard(int index, String title, String subtitle) {
    bool isSelected = _selectedFrequency == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = index),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: ColorManager.secondaryBackGround,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? ColorManager.brown500
                : ColorManager.backgroundPressed100,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumStyle18(color: ColorManager.grayBlack400),
                ),
                Text(
                  subtitle,
                  style: getMediumStyle18(
                    color: ColorManager.brown300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            //tik mark on selected
            if (isSelected)
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: ColorManager.primaryButton,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  IconManager.tikMark,
                  width: 8.w,
                  height: 8.h,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDateDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorManager.backgroundPressed100),
      ),
      child: Row(
        children: [
          SvgPicture.asset(IconManager.calendar),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Custom date",
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
          ),
          SvgPicture.asset(IconManager.arrowDown),
        ],
      ),
    );
  }
}
