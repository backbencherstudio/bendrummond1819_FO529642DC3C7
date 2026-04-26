import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.customOutlineButtonBorder,
                  ),
                  Text(
                    "Add goal",
                    style: getSemiBoldStyle22(color: ColorManager.textPrimary),
                  ),
                ],
              ),

              SizedBox(height: 35.h),

              // ========== Saving for Section ================
              _buildLabel("What are you saving for?"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: 'Buy a Iphone 17 Pro'),

              SizedBox(height: 6.h),

              // Suggestion Chips
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildSuggestionChip("Emergency fund"),
                  _buildSuggestionChip("Vacation"),
                  _buildSuggestionChip("New car"),
                  _buildSuggestionChip("Down payment"),
                  _buildSuggestionChip("Holiday gifts"),
                ],
              ),

              SizedBox(height: 12.h),

              // ===================== Amount ========================
              _buildLabel("Amount"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '60',
                prefixIcon: SvgPicture.asset(IconManager.dollar),
              ),

              SizedBox(height: 12.h),

              // ================ Frequency Section ===================
              _buildLabel("Frequency"),
              SizedBox(height: 6.h),
              _buildDropdownField("Per month"),
              SizedBox(height: 24.h),
              // ================ Add Goal Button =====================
              PrimaryButton(
                title: 'Add Goal',
                onTap: () {
                  Navigator.pop(context);
                  Utils.showToast(
                    message: "Goal Added",
                    backgroundColor: ColorManager.successColor,
                    textColor: ColorManager.whiteColor,
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========== Section Labels ===========
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  // ======= Suggestion Chip ==========
  Widget _buildSuggestionChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: ColorManager.backgroudNormal,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: getMediumStyle18(color: ColorManager.brown300, fontSize: 14),
      ),
    );
  }

  // ======== Dropdown Field ==============
  Widget _buildDropdownField(String value) {
    return Container(
      padding: EdgeInsets.only(
        top: 14.r,
        right: 12.r,
        bottom: 14.r,
        left: 16.r,
      ),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.borderE0D9D1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: ColorManager.secondaryBackGround,
          value: value,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ColorManager.primaryButton,
            size: 20.sp,
          ),
          isExpanded: true,
          style: getRegularStyle16_400(color: ColorManager.brown400),
          items: [value].map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
