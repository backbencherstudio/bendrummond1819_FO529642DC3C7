import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/image_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/mixins/keyboard_aware_header.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardAwareHeader(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageManager.onBoardingImg,
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 12),
                  customLogoText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
