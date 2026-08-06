import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabeledFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isSecured;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Widget? trailing;
  final void Function(String)? onChanged;

  const LabeledFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.isSecured = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.trailing,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailing == null)
          Text(
            label,
            style: getRegularStyle14_400(color: ColorManager.brown300),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: getRegularStyle14_400(color: ColorManager.brown300),
              ),
              trailing!,
            ],
          ),
        SizedBox(height: 5.h),
        CustomFromField(
          hintText: hintText,
          controller: controller,
          focusNode: focusNode,
          isSecured: isSecured,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

