import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dotted_line_painter.dart';

class BreakdownRow extends StatelessWidget {
  const BreakdownRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: getRegularStyle16_400(color: ColorManager.cA08060)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: CustomPaint(painter: DottedLinePainter()),
          ),
        ),
        Text(value, style: getRegularStyle16_400(color: ColorManager.c7A5E38)),
      ],
    );
  }
}
