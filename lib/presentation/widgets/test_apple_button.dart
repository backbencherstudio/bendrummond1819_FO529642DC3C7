import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum SocialProvider { apple, google }

enum SocialButtonStyle { black, white, whiteOutlined }

class SocialSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final SocialProvider provider;
  final SocialButtonStyle style;
  final String title;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.onTap,
    required this.provider,
    this.style = SocialButtonStyle.black,
    required this.title,
    this.isLoading = false,
  }) : assert(
         provider != SocialProvider.apple ||
             title == 'Sign in with Apple' ||
             title == 'Sign up with Apple' ||
             title == 'Continue with Apple',
         'Apple only allows "Sign in with Apple", "Sign up with Apple", or "Continue with Apple" as the title.',
       );

  @override
  Widget build(BuildContext context) {
    final bool isDark = style == SocialButtonStyle.black;
    final bool showOutline = style == SocialButtonStyle.whiteOutlined;

    final Color bg = isDark ? Colors.black : Colors.white;
    final Color fg = isDark ? Colors.white : Colors.black;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12.r),
            border: showOutline
                ? Border.all(color: Colors.black26, width: 1.w)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isLoading) ...[
                SizedBox(width: 20.w, height: 20.h, child: _buildLogo(isDark)),
                SizedBox(width: 10.w),
              ],
              Flexible(
                child: isLoading
                    ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: fg,
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: fg,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    switch (provider) {
      case SocialProvider.apple:
        return Image.asset(
          isDark
              ? 'assets/icons/apple_icon.png'
              : 'assets/icons/apple_icon.png',
          fit: BoxFit.contain,
        );
      case SocialProvider.google:
        return SvgPicture.asset(
          'assets/icons/google_icon.svg',
          fit: BoxFit.contain,
        );
    }
  }
}
