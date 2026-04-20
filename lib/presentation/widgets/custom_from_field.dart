import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resource/constants/color_manger.dart';

class CustomFromField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isSecured;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Color? fillColor;
  final TextStyle? style;
  final bool? filled;
  final VoidCallback? onTap;
  final bool readOnly;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints; // prefix এর জন্য constraints যোগ করা হয়েছে
  final int? maxLines;

  const CustomFromField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.isSecured = false,
    this.onChanged,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.fillColor,
    this.style,
    this.filled,
    this.onTap,
    this.readOnly = false,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isSecured,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,
      style: style ?? getRegularStyle16_400(color: ColorManager.brown400),
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        filled: filled ?? true,
        fillColor: fillColor ?? ColorManager.formFieldColor,
        hintText: hintText,
        labelText: labelText,
        hintStyle: style ?? getRegularStyle16_400(color: ColorManager.brown400),

        // Prefix Icon setup with constraints
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: FittedBox(fit: BoxFit.contain, child: prefixIcon!),
          ),
        )
            : null,
        prefixIconConstraints: prefixIconConstraints ?? BoxConstraints(
          minWidth: 44.w,
          minHeight: 20.h,
        ),

        // Suffix Icon setup with constraints
        suffixIcon: suffixIcon != null
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: FittedBox(fit: BoxFit.contain, child: suffixIcon!),
          ),
        )
            : null,
        suffixIconConstraints: suffixIconConstraints ?? BoxConstraints(
          minWidth: 44.w,
          minHeight: 20.h,
        ),

        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: ColorManager.borderColor1),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: ColorManager.borderColor1,
                width: 1.5,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}