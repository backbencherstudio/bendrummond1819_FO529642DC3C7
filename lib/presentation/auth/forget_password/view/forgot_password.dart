import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_from_field.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _emailController = TextEditingController();

  Future<void> handForgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    final success = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .forgotPassword(email: email);

    if (success && mounted) {
      Navigator.pushNamed(
        context,
        RoutesName.forgotPasswordOtpRoute,
        arguments: email,
      );
    } else if (mounted) {
      final state = ref.read(forgotPasswordViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? "Request failed")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Forgot Password",
                      style: getBoldStyle32(
                        color: ColorManager.brown,
                      ).copyWith(letterSpacing: -0.45),
                    ),
                    SizedBox(height: 15.h),

                    Text(
                      "Email",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown300,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomFromField(
                      hintText: "you@example.com",
                      controller: _emailController,
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                title: "Send",
                isLoading: state.isLoading,
                onTap: () => handForgotPassword(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
