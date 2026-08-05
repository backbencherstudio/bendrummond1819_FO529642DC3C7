import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthSwitchLink extends StatelessWidget {
  final String leadingText;
  final String linkText;
  final VoidCallback onTap;

  const AuthSwitchLink({
    super.key,
    required this.leadingText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: getRegularStyle14_400(color: ColorManager.brown300),
          children: [
            TextSpan(text: leadingText),
            TextSpan(
              text: linkText,
              style: getRegularStyle14_500(color: ColorManager.brown).copyWith(
                decoration: TextDecoration.underline,
                decorationColor: ColorManager.brown,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
