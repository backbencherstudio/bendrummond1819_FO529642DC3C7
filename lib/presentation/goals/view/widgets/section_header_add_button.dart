import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onAddTap;

  const SectionHeaderAddButton({
    super.key,
    required this.label,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: getRegularStyle16_400(color: ColorManager.brown400)),
        InkWell(
          onTap: onAddTap,
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: ColorManager.backgroundCard,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: ColorManager.primaryButton,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
