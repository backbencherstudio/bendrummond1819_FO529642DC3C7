import 'package:bendrummond1819_fo529642dc3c7/presentation/mixins/keyboard_aware_scroll_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/primary_button.dart';
import '../../mixins/social_login_mixin.dart';
import '../../signin/widgets/cutom_divider.dart';
import '../viewmodel/signup_viewmodel.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_headline.dart';
import '../../widgets/auth_switch_link.dart';
import '../../widgets/date_of_birth_field.dart';
import '../../widgets/labeled_form_field.dart';
import '../../widgets/social_login_buttons.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen>
    with KeyboardAwareScrollMixin, SocialLoginMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _dobFocusNode = FocusNode();
  final _signUpButtonKey = GlobalKey();

  bool get _isFormValid =>
      _fullNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _dobController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    registerAutoScrollFocus(_fullNameFocusNode, _signUpButtonKey);
    registerAutoScrollFocus(_emailFocusNode, _signUpButtonKey);
    registerAutoScrollFocus(_passwordFocusNode, _signUpButtonKey);
    registerAutoScrollFocus(_phoneFocusNode, _signUpButtonKey);
    registerAutoScrollFocus(_dobFocusNode, _signUpButtonKey);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _fullNameFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _dobController.dispose();
    _dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(signUpViewModelProvider).value ??
        const SignUpState(
          isEmailLoading: false,
          isGoogleLoading: false,
          isAppleLoading: false,
        );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AuthHeader(),
            Container(
              width: double.infinity,
              color: ColorManager.cF0EBE3,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  const AuthHeadline(
                    title: "Take control of your finances",
                    subtitle: "See what's safe to spend",
                  ),

                  SizedBox(height: 25.h),

                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabeledFormField(
                          label: "Your full name",
                          hintText: "What should we call you?",
                          controller: _fullNameController,
                          focusNode: _fullNameFocusNode,
                          onChanged: (_) => setState(() {}),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? "Full name is required"
                              : null,
                        ),
                        SizedBox(height: 12.h),

                        LabeledFormField(
                          label: "Email address",
                          hintText: "you@example.com",
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          onChanged: (_) => setState(() {}),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email is required";
                            }
                            final emailRegex = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.h),

                        LabeledFormField(
                          label: "Password",
                          hintText: "Your password",
                          controller: _passwordController,
                          isSecured: true,
                          focusNode: _passwordFocusNode,
                          onChanged: (_) => setState(() {}),
                          validator: (value) =>
                              (value == null || value.isEmpty)
                              ? "Password is required"
                              : null,
                        ),
                        SizedBox(height: 12.h),

                        LabeledFormField(
                          label: "Phone number",
                          hintText: "(123) 456-7890",
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                          onChanged: (_) => setState(() {}),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? "Phone number is required"
                              : null,
                        ),
                        SizedBox(height: 12.h),

                        DateOfBirthField(
                          label: "Date of birth",
                          controller: _dobController,
                          focusNode: _dobFocusNode,
                          onChanged: (_) => setState(() {}),
                        ),

                        SizedBox(height: 25.h),

                        KeyedSubtree(
                          key: _signUpButtonKey,
                          child: PrimaryButton(
                            title: "Create account",
                            isLoading: state.isEmailLoading,
                            isEnabled: _isFormValid,
                            onTap: () => _handleRegister(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  SocialLoginButtons(
                    isGoogleLoading: state.isGoogleLoading,
                    onGoogleTap: () => handleGoogleLogin(),
                    isAppleLoading: state.isAppleLoading,
                    onAppleTap: () => handleAppleLogin(),
                  ),

                  SizedBox(height: 20.h),
                  const CustomDivider(),
                  SizedBox(height: 20.h),

                  AuthSwitchLink(
                    leadingText: "Already have an account? ",
                    linkText: "Sign in",
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.signInRoute),
                  ),

                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //******** Helper Methods**************

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final success = await ref
        .read(signUpViewModelProvider.notifier)
        .register(
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text.trim(),
          dob: _dobController.text.trim(),
        );

    if (success && mounted) {
      Navigator.pushReplacementNamed(
        context,
        RoutesName.signupOtpScreen,
        arguments: _emailController.text.trim(),
      );
    } else if (!success && mounted) {
      final state = ref.read(signUpViewModelProvider).value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state?.errorMessage ?? "Registration failed")),
      );
    }
  }

  //***************** Social Login Mixin ***********************
  @override
  bool get isGoogleLoading =>
      ref.read(signUpViewModelProvider).value?.isGoogleLoading ?? false;

  @override
  bool get isAppleLoading =>
      ref.read(signUpViewModelProvider).value?.isAppleLoading ?? false;

  @override
  String? get errorMessage =>
      ref.read(signUpViewModelProvider).value?.errorMessage;

  @override
  Future<bool> googleSignIn() async {
    return ref.read(signUpViewModelProvider.notifier).googleSignIn();
  }

  @override
  Future<bool> appleSignIn() async {
    return ref.read(signUpViewModelProvider.notifier).appleSignIn();
  }

  @override
  void onSocialLoginSuccess() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.bottomNavRoute,
      (route) => false,
    );
  }
}

