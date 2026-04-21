import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resource/constants/color_manger.dart';
import '../../core/resource/constants/style_manager.dart';

Widget customLogoText() {
  return Text(
    "STABILITY",
    style: getRegularStyle16_400(
      fontSize: 20.sp,
      color: ColorManager.brown500,
    ).copyWith(letterSpacing: 6, fontFamily: "Serif"),
  );
}