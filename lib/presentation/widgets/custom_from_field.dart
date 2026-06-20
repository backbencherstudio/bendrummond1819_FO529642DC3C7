import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resource/constants/color_manger.dart';

class CustomFromField extends StatefulWidget {
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
  final BoxConstraints? prefixIconConstraints;
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
  State<CustomFromField> createState() => _CustomFromFieldState();
}

class _CustomFromFieldState extends State<CustomFromField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.isSecured ? _obscured : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      maxLines: widget.maxLines ?? 1,
      readOnly: widget.readOnly,
      style: widget.style ?? getRegularStyle16_400(color: ColorManager.brown400),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        filled: widget.filled ?? true,
        fillColor: widget.fillColor ?? ColorManager.backgroundSecondary,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: getRegularStyle16_400(color: ColorManager.brown300),

        // Prefix Icon setup with constraints
        prefixIcon: widget.prefixIcon != null
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: FittedBox(fit: BoxFit.contain, child: widget.prefixIcon!),
          ),
        )
            : null,
        prefixIconConstraints: widget.prefixIconConstraints ?? BoxConstraints(
          minWidth: 44.w,
          minHeight: 20.h,
        ),

        // Suffix Icon setup with constraints
        suffixIcon: widget.isSecured
            ? GestureDetector(
                onTap: () => setState(() => _obscured = !_obscured),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_off_outlined
                            : Icons.remove_red_eye_outlined,
                        color: ColorManager.brown,
                      ),
                    ),
                  ),
                ),
              )
            : widget.suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child:
                          FittedBox(fit: BoxFit.contain, child: widget.suffixIcon!),
                    ),
                  )
                : null,
        suffixIconConstraints: widget.suffixIconConstraints ?? BoxConstraints(
          minWidth: 44.w,
          minHeight: 20.h,
        ),

        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: ColorManager.borderColor1),
            ),
        focusedBorder: widget.focusedBorder ??
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