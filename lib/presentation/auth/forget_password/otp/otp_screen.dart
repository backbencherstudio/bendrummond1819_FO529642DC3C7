import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/custom_otp_field.dart';
import '../../../widgets/primary_button.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        backgroundColor: ColorManager.secondary,
        leading: customBackButton(
          context,
          borderColor: ColorManager.borderColor,
        ),
        title: customLogoText(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter OTP Code",
                    style: getBoldStyle24(
                      fontSize: 32.sp,
                      color: ColorManager.brown,
                    ).copyWith(letterSpacing: -0.45),
                  ),
                  SizedBox(height: 15.h),

                  /// ************ otp Field *****************
                  CustomPinCodeField(),
                ],
              ),
            ),

            /// *************** send btn *******************
            PrimaryButton(
              title: "Verify",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.forgotPasswordOtpRoute);
              },
            ),
            SizedBox(height: 15.h),
            customDivider(),
            SizedBox(height: 15.h),

            /// ************ rich text ******************
            Center(
              child: RichText(
                text: TextSpan(
                  style: getRegularStyle16_400(
                    color: ColorManager.brown300,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(text: "Didn't get the OTP? "),
                    TextSpan(
                      text: "Resend",
                      style:
                          getRegularStyle16_500(
                            color: ColorManager.brown,
                            fontSize: 14.sp,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorManager.brown,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, RoutesName.signUpRoute);
                        },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// ************* custom widget **************
  Widget customDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: ColorManager.brown200, thickness: 2)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: 4.r,
            height: 6.r,
            decoration: BoxDecoration(
              color: ColorManager.gold2,
              borderRadius: BorderRadius.circular(999.r),
              //shape: BoxShape.circle,
            ),
          ),
        ),

        Expanded(child: Divider(color: ColorManager.brown200, thickness: 2)),
      ],
    );
  }
}
