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

  Future<void> handleResetPassword() async {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a new password")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final success = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .resetPassword(
          password: password,
          passwordConfirmation: confirmPassword,
        );

    if (success && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.signInRoute,
        (route) => false,
      );
    } else if (mounted) {
      final state = ref.read(forgotPasswordViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage ?? "Failed to reset password"),
        ),
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
