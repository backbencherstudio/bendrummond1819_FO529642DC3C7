import 'dart:ui';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/set_up7_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../balances/view/balances_screen.dart';

class SetUp6Screen extends ConsumerStatefulWidget {
  const SetUp6Screen({super.key});

  @override
  ConsumerState<SetUp6Screen> createState() => _SetUp6ScreenState();
}

class _SetUp6ScreenState extends ConsumerState<SetUp6Screen> {
  bool isAdding = false;
  List<Map<String, String>> bills = [];

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final dayController = TextEditingController();

  void _addNewBill() {
    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      setState(() {
        bills.add({
          'name': nameController.text,
          'amount': amountController.text,
          'day': dayController.text,
        });
        isAdding = false;
        nameController.clear();
        amountController.clear();
        dayController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Any other regular bills?",
                style: getBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 15.h),
              Text(
                "Subscriptions, insurance, utilities — anything monthly.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: bills.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return savedBillCard(bills[index]);
                },
              ),

              isAdding ? _buildInputForm() : _buildAddBillButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// ************* Saved bill card widget **************
  Widget savedBillCard(Map<String, String> bill) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.brown200, width: 1.5.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bill['name']!,
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              Text(
                "Monthly",
                style: getRegularStyle14_400(color: ColorManager.grayBlack400),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "\$${bill['amount']}",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => setState(() => bills.remove(bill)),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    bool isChecked = false;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.borderColor1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bill Name",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "Electricity bill",
            controller: nameController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Amount",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomFromField(
                      hintText: "100",
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: SvgPicture.asset(IconManager.dollar),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Due day",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomFromField(
                      hintText: "4",
                      controller: dayController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
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
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onTap: () => setState(() => isAdding = false),
                  title: "Cancel",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButton(onTap: _addNewBill, title: "Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddBillButton() {
    return CustomPaint(
      painter: DashedRectPainter(color: ColorManager.brown400),
      child: InkWell(
        onTap: () => setState(() => isAdding = true),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor: ColorManager.backgroundCard,
                child: Icon(Icons.add, color: ColorManager.brown, size: 20.sp),
              ),
              SizedBox(width: 15.w),
              Text(
                "Add a bill",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
