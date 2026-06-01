import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resource/constants/color_manger.dart';
import '../../core/resource/constants/icon_manager.dart';
import '../../core/resource/utils.dart';
import 'custom_from_field.dart';

class CustomDatePickerField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onDateSelected;
  final String? Function(String?)? validator;

  const CustomDatePickerField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onDateSelected,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFromField(
      controller: controller,
      hintText: hintText,
      validator: validator,
      readOnly: true, // Blocks manual typing, opens date picker on tap
      
      // 1. Match the client's custom background color
      fillColor: ColorManager.secondaryBackGround,
      filled: true,

      // 2. Exact padding provided in the client's layout
      contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),

      // 3. Prefix Icon: Client's SVG Calendar Icon
      prefixIcon: SvgPicture.asset(IconManager.calendar),
      prefixIconConstraints: BoxConstraints(
        minWidth: 24.w, // Balanced layout constraint for the SVG asset
      ),

      // 4. Suffix Icon: Client's SVG Down Arrow
      suffixIcon: SvgPicture.asset(IconManager.arrowDown),
      suffixIconConstraints: BoxConstraints(
        minWidth: 24.w,
      ),

      // 5. Borders matching the client's custom radius and colors
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: ColorManager.backgroundPressed100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: ColorManager.backgroundPressed100,
          width: 1.5,
        ),
      ),

      // 6. Action trigger on tap
      onTap: () async {
        await Utils.selectDate(context, controller);

        if (controller.text.isNotEmpty && onDateSelected != null) {
          onDateSelected!();
        }
      },
    );
  }
}