import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_from_field.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/primary_button.dart';
import '../../../../core/resource/utils.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class SetNewPasswordScreen extends ConsumerStatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  ConsumerState<SetNewPasswordScreen> createState() =>
      _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends ConsumerState<SetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isInteracted = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  String? get _passwordError {
    if (!_isInteracted) return null;
    final password = _passwordController.text;
    if (password.isEmpty) return "Please enter a new password";
    if (password.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? get _confirmPasswordError {
    if (!_isInteracted) return null;
    final confirmPassword = _confirmPasswordController.text;
    if (confirmPassword.isEmpty) return "Please confirm your password";
    if (_passwordController.text != confirmPassword) return "Passwords do not match";
    return null;
  }

  Future<void> handleResetPassword() async {
    setState(() => _isInteracted = true);
    
    if (_passwordError != null || _confirmPasswordError != null) {
      return;
    }

    final success = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .resetPassword(password: _passwordController.text);

    if (success && mounted) {
      Utils.showToast(
        message: "Password reset successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.signInRoute,
        (route) => false,
      );
    } else if (mounted) {
      final state = ref.read(forgotPasswordViewModelProvider);
      Utils.showErrorToast(
        message: state.errorMessage ?? "Failed to reset password",
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      "Set New Password",
                      style: getBoldStyle32(
                        color: ColorManager.brown,
                      ).copyWith(letterSpacing: -0.45),
                    ),
                    SizedBox(height: 15.h),

                    Text(
                      "Password",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown300,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomFromField(
                      hintText: "Enter your password",
                      controller: _passwordController,
                      isSecured: true,
                      errorText: _passwordError,
                    ),

                    SizedBox(height: 15.h),

                    Text(
                      "Confirm Password",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown300,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomFromField(
                      hintText: "Confirm your password",
                      controller: _confirmPasswordController,
                      isSecured: true,
                      errorText: _confirmPasswordError,
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                title: "Update Password",
                isLoading: state.isLoading,
                onTap: () => handleResetPassword(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
