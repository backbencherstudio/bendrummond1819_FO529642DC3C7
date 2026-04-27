import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/style_manager.dart';
import '../../../widgets/custom_back_button.dart';

class CompletePaymentScreen extends StatefulWidget {
  const CompletePaymentScreen({super.key});

  @override
  State<CompletePaymentScreen> createState() => _CompletePaymentScreenState();
}

class _CompletePaymentScreenState extends State<CompletePaymentScreen> {
  bool _saveCard = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =============== Header Section ==================
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customBackButton(context),
                  SizedBox(width: 12.w),
                  Text(
                    'Choose Your Plan',
                    style: getBoldStyle24(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildLabel("Account Holder Name"),
              CustomFromField(hintText: 'Luis Hamilton'),
              SizedBox(height: 16.h),
              _buildLabel("Card Number"),
              CustomFromField(hintText: '1234 5678 9000 0000'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Expire Date"),
                        CustomFromField(hintText: '04/30'),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("CVV"),
                        CustomFromField(hintText: '345'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // ============ Checkbox Row ==============
              GestureDetector(
                onTap: () => setState(() => _saveCard = !_saveCard),
                child: Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: ColorManager.textPrimary,
                          width: 1.5.w,
                        ),
                      ),
                      child: _saveCard
                          ? Icon(
                              Icons.check,
                              size: 12.sp,
                              color: ColorManager.textPrimary,
                            )
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Save Card Informations",
                      style: getLightStyle14_500(color: ColorManager.grayBlack400),
                    ),
                  ],
                ),
              ),
              Spacer(),
              // ================ Primary Button Section ==============
              PrimaryButton(
                title: 'Pay Now',
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.resultScreen);
                },
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  "You'll receive a digital invoice to your mail after successful payment",
                  textAlign: TextAlign.center,
                  style: getLightStyle14_500(color: ColorManager.grayBlack400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.99.h),
      child: Text(
        text,
        style: getLightStyle14_400(color: ColorManager.brown300),
      ),
    );
  }
}
