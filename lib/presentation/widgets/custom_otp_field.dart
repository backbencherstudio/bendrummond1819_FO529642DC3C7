import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../core/resource/constants/color_manger.dart';

class CustomPinCodeField extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onCompleted;

  const CustomPinCodeField({
    super.key,
    this.length = 4,
    this.controller,
    this.validator,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 74.w,
      height: 64.h,
      textStyle: getRegularStyle20_500(color: ColorManager.brown400),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.brown200,width: 1.5.w),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: ColorManager.brown, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: ColorManager.brown),
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: validator,
      preFilledWidget: Text(
        "-",
        style: defaultPinTheme.textStyle?.copyWith(color: ColorManager.brown),
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      onCompleted: onCompleted,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15.h),
            width: 2,
            height: 25.h,
            color: ColorManager.brown,
          ),
        ],
      ),
    );
  }
}
