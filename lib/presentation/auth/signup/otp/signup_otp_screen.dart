import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/resource/utils.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/custom_otp_field.dart';
import '../../../widgets/primary_button.dart';
import 'signup_otp_viewmodel.dart';

class SignupOtpScreen extends ConsumerStatefulWidget {
  const SignupOtpScreen({super.key});

  @override
  ConsumerState<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends ConsumerState<SignupOtpScreen> {
  final _otpController = TextEditingController();
  String _phone = '';
  String _userId = '';
  Timer? _timer;
  int _secondsRemaining = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _phone = args['phone'] as String? ?? '';
      _userId = args['userId'] as String? ?? '';
    }
  }

  Future<void> handleVerifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || _phone.isEmpty || _userId.isEmpty) {
      Utils.showErrorToast(message: "Please enter the OTP");
      return;
    }

    final success = await ref
        .read(signupOtpViewModelProvider.notifier)
        .verifyPhone(userId: _userId, otp: otp);

    if (success && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.setUpScreen,
        (route) => false,
      );
    } else if (mounted) {
      final state = ref.read(signupOtpViewModelProvider);
      Utils.showErrorToast(message: state.errorMessage ?? "Verification failed");
    }
  }

  Future<void> handleResendOtp() async {
    if (_userId.isEmpty) return;
    if (_secondsRemaining > 0) return;

    final success = await ref
        .read(signupOtpViewModelProvider.notifier)
        .resendPhoneOtp(userId: _userId);

    if (mounted) {
      if (success) {
        _startTimer();
        Utils.showToast(
          message: "OTP resent successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Utils.showErrorToast(message: "Failed to resend OTP");
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  String get _timerText {
    if (_secondsRemaining == 0) return "Resend";
    final minutes = (_secondsRemaining / 60).floor();
    final seconds = _secondsRemaining % 60;
    return "Resend in $minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupOtpViewModelProvider);

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
                      style: getBoldStyle32(color: ColorManager.textPrimary),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "We have sent an OTP code to your\nphone number $_phone",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown300,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    CustomPinCodeField(controller: _otpController),
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
                        text: _timerText,
                        style: getRegularStyle14_500(
                          color: _secondsRemaining == 0
                              ? ColorManager.brown
                              : ColorManager.brown300,
                        ).copyWith(
                          decoration: _secondsRemaining == 0
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: ColorManager.brown,
                        ),
                        recognizer: _secondsRemaining == 0
                            ? (TapGestureRecognizer()..onTap = () => handleResendOtp())
                            : null,
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
