import 'dart:io';

import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/test_apple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButtons extends StatelessWidget {
  final bool isGoogleLoading;
  final VoidCallback onGoogleTap;
  final bool isAppleLoading;
  final VoidCallback? onAppleTap;
  final bool showApple;

  const SocialLoginButtons({
    super.key,
    required this.isGoogleLoading,
    required this.onGoogleTap,
    this.isAppleLoading = false,
    this.onAppleTap,
    this.showApple = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isAndroid) ...[
          SocialSignInButton(
            title: "Sign in with Google",
            provider: SocialProvider.google,
            style: SocialButtonStyle.white,
            isLoading: isGoogleLoading,
            onTap: onGoogleTap,
          ),
        ],
        if (Platform.isIOS && showApple && onAppleTap != null) ...[
          SizedBox(height: 12.h),
          SocialSignInButton(
            provider: SocialProvider.apple,
            title: "Continue with Apple",
            onTap: onAppleTap!,
            style: SocialButtonStyle.white,
          ),
          // CustomOutlinedButton(
          //   title: "Continue with Apple",
          //   icon: Image.asset(IconManager.appleIcon, width: 18, height: 18),
          //   textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          //   onTap: onAppleTap!,
          // ),
        ],
      ],
    );
  }
}
