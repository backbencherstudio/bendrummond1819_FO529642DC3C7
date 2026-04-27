import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resource/constants/color_manger.dart';
import '../../core/resource/constants/style_manager.dart';

Widget customLogoText() {
  return Text(
    "STABILITY",
    style: getSemiBoldStyle22(
      color: ColorManager.brown500,
      fontSize: 24.sp
    ).copyWith(letterSpacing: 6),
  );
}