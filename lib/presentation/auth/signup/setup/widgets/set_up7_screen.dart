import 'dart:ui';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/set_up8_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../../core/resource/utils.dart';
import '../../../../balances/view/balances_screen.dart';
import '../../../../widgets/custom_from_field.dart';
import '../../../../widgets/outline_button.dart';
import '../../../../widgets/primary_button.dart';

class SetUp7Screen extends ConsumerStatefulWidget {
  const SetUp7Screen({super.key});

  @override
  ConsumerState<SetUp7Screen> createState() => _SetUp7ScreenState();
}

class _SetUp7ScreenState extends ConsumerState<SetUp7Screen> {
  bool isAdding = false;
  List<Map<String, String>> debts = [];
  bool isFrequencyExpanded = false;
  String selectedFrequency = "Beginning of month";
  bool isChecked = false;

  final whatIsItController = TextEditingController();
  final amountController = TextEditingController();
  final frequentlyController = TextEditingController();

  void _addNewBill() {
    if (whatIsItController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      setState(() {
        debts.add({
          'name': whatIsItController.text,
          'amount': amountController.text,
          'frequently': frequentlyController.text,
        });
        isAdding = false;
        whatIsItController.clear();
        amountController.clear();
        frequentlyController.clear();
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
                "Any debts to account for?",
                style: getBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 15.h),
              Text(
                "Student loans, credit cards, personal loans — what you pay regularly.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: debts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return savedBillCard(debts[index]);
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
                bill['frequently']!,
                style: getRegularStyle14_400(color: ColorManager.grayBlack400),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "\$${bill['amount'] ?? '0'}",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => setState(() => debts.remove(bill)),
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
            "What is it?",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "Credit card",
            controller: whatIsItController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12.h),
          Text(
            "Bill Amount",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "25",
            controller: amountController,
            keyboardType: TextInputType.number,
            prefixIcon: SvgPicture.asset(IconManager.dollar),
          ),
          SizedBox(height: 12.h),
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
                  // child: isChecked
                  //     ? Icon(
                  //         Icons.check,
                  //         size: 14.sp,
                  //         color: ColorManager.textPrimary,
                  //       )
                  //     : null,
                ),
                SizedBox(width: 12.w),
                Text(
                  "Set as Weekly/Monthly Payment",
                  style: getRegularStyle14_400(color: ColorManager.brown),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Frequency",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: () {
              setState(() {
                isFrequencyExpanded = !isFrequencyExpanded;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: IgnorePointer(
              child: CustomFromField(
                hintText: "Select frequency",
                controller: frequentlyController..text = selectedFrequency,
                keyboardType: TextInputType.text,
                suffixIcon: Icon(
                  isFrequencyExpanded
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  color: ColorManager.brown400,
                ),
                readOnly: true,
              ),
            ),
          ),

          // Expanded Options
          if (isFrequencyExpanded)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.backgroundSecondary,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.borderColor1),
              ),
              child: Column(
                children: [
                  _buildFrequencyOption("Beginning of month"),
                  Divider(height: 1, color: ColorManager.borderColor1),
                  _buildFrequencyOption("Custom date", isDate: true),
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

  Widget _buildFrequencyOption(String title, {bool isDate = false}) {
    return InkWell(
      onTap: () async {
        if (isDate) {
          await Utils.selectDate(context, frequentlyController);

          if (frequentlyController.text.isNotEmpty) {
            setState(() {
              selectedFrequency = frequentlyController.text;
              isFrequencyExpanded = false;
            });
          }
        } else {
          setState(() {
            selectedFrequency = title;
            frequentlyController.text = title;
            isFrequencyExpanded = false;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Text(
          title,
          style: getRegularStyle16_400(color: ColorManager.textPrimary),
        ),
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
                "Add a debt",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
