import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashed_rect_painter.dart';

class AddActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AddActionButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedRectPainter(color: ColorManager.primaryButton),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
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
              SizedBox(width: 15.w),
              Text(
                label,
                style: getRegularStyle16_400(
                  color: ColorManager.brown400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
