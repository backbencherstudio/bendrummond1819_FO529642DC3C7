import 'dart:ui';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../balances/view/balances_screen.dart';
import '../../../../widgets/custom_from_field.dart';
import '../../../../widgets/outline_button.dart';
import '../../../../widgets/primary_button.dart';

class SetUp8Screen extends ConsumerStatefulWidget {
  const SetUp8Screen({super.key});

  @override
  ConsumerState<SetUp8Screen> createState() => _SetUp8ScreenState();
}

class _SetUp8ScreenState extends ConsumerState<SetUp8Screen> {
  bool isAdding = false;
  List<Map<String, String>> saving = [];

  final savingNameController = TextEditingController();
  final amountController = TextEditingController();
  final frequencyController = TextEditingController();

  void _addNewBill() {
    if (savingNameController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      setState(() {
        saving.add({
          'savingName': savingNameController.text,
          'amount': amountController.text,
          'frequently': frequencyController.text,
        });
        isAdding = false;
        savingNameController.clear();
        amountController.clear();
        frequencyController.clear();
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
                "Saving for anything?",
                style: getBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 15.h),
              Text(
                "Start small — even a little helps. You can add more later.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: saving.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return savingCard(saving[index]);
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
  Widget savingCard(Map<String, String> save) {
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
                save['savingName'] ?? "N/A",
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
                "\$${save['amount']}",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => setState(() => saving.remove(save)),
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
    final List<String> suggestions = [
      "Emergency fund",
      "Vacation",
      "New car",
      "Down payment",
      "Holiday gifts",
    ];
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
            "What are you saving for?",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "Buy a Iphone 17 Pro",
            controller: savingNameController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: suggestions.map((suggestion) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    savingNameController.text = suggestion;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.backgroudNormal,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    suggestion,
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
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
                      "Frequency",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomFromField(
                      hintText: "Per month",
                      controller: frequencyController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorManager.brown400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                "Add a goal",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
