import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resource/constants/color_manger.dart';
import '../../core/resource/constants/style_manager.dart';

Widget customLogoText() {
  return Text(
    "STABILITY",
    style: getSemiBoldStyle22(
      color: ColorManager.brown500,
      fontSize: (24.sp).clamp(24.0, 34.0),
    ).copyWith(letterSpacing: 6),
  );
}

