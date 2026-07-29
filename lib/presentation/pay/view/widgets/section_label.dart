import 'package:flutter/material.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown400),
    );
  }
}
