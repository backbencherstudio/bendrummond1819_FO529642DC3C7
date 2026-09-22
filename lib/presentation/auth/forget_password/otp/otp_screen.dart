import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/custom_otp_field.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordOtpScreen extends ConsumerStatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  ConsumerState<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState
    extends ConsumerState<ForgotPasswordOtpScreen> {
  final _otpController = TextEditingController();
  String _email = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _email = ModalRoute.of(context)?.settings.arguments as String? ?? _email;
  }

  Future<void> handleVerifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the OTP")),
      );
      return;
    }

    final success = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .verifyOtp(otp: otp);

    if (success && mounted) {
      Navigator.pushNamed(
        context,
        RoutesName.resetNewPasswordRoute,
        arguments: _email,
      );
    } else if (mounted) {
      final state = ref.read(forgotPasswordViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? "Verification failed")),
      );
    }
  }

  Future<void> handleResendOtp() async {
    final success = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .forgotPassword(email: _email);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? "OTP resent successfully" : "Failed to resend OTP"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordViewModelProvider);

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
          child: Column(
            children: [
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.borderColor,
                  ),
                  SizedBox(width: 12.w),
                  customLogoText(),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter OTP Code",
                      style: getBoldStyle32(
                        color: ColorManager.brown,
                      ).copyWith(letterSpacing: -0.45),
                    ),
                    SizedBox(height: 15.h),

                    CustomPinCodeField(
                      controller: _otpController,
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                title: "Verify",
                isLoading: state.isLoading,
                onTap: () => handleVerifyOtp(),
              ),
              SizedBox(height: 15.h),
              customDivider(),
              SizedBox(height: 15.h),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                    children: [
                      TextSpan(text: "Didn't get the OTP? "),
                      TextSpan(
                        text: "Resend",
                        style: getRegularStyle14_500(
                          color: ColorManager.brown,
                        ).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: ColorManager.brown,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => handleResendOtp(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

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
            ),
          ),
        ),

        Expanded(child: Divider(color: ColorManager.brown200, thickness: 2)),
      ],
    );
  }
}
