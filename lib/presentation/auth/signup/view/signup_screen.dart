import 'package:bendrummond1819_fo529642dc3c7/presentation/mixins/keyboard_aware_scroll_mixin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/icon_manager.dart';
import '../../../../core/resource/constants/image_manager.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../mixins/keyboard_aware_header.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_from_field.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/primary_button.dart';
import '../../mixins/social_login_mixin.dart';
import '../viewmodel/signup_viewmodel.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen>
    with KeyboardAwareScrollMixin, SocialLoginMixin {
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

  String? _emailError;

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            KeyboardAwareHeader(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      ImageManager.onBoardingImg,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        children: [
                          customBackButton(
                            context,
                            borderColor: ColorManager.backgroundPressed100,
                          ),
                          SizedBox(width: 12),
                          customLogoText(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              color: ColorManager.cF0EBE3,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  Text(
                    "Take control of your finances",
                    style: getBoldStyle24(
                      fontSize: 28.sp,
                      color: ColorManager.brown,
                    ).copyWith(letterSpacing: -0.5),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "See what's safe to spend",
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),

                  SizedBox(height: 25.h),

                  /// ************ name Field *****************
                  Text(
                    "Your full name",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 5.h),
                  CustomFromField(
                    hintText: "What should we call you?",
                    controller: _fullNameController,
                    focusNode: _fullNameFocusNode,
                  ),

                  SizedBox(height: 12.h),

                  /// ************ email Field *****************
                  Text(
                    "Email address",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "you@example.com",
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                  ),

                  SizedBox(height: 12.h),

                  /// ***************** password field ****************
                  Text(
                    "Password",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "Your password",
                    controller: _passwordController,
                    isSecured: true,
                    focusNode: _passwordFocusNode,
                  ),

                  SizedBox(height: 12.h),

                  /// ************ phone Field *****************
                  Text(
                    "Phone number",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "(123) 456-7890",
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                  ),

                  SizedBox(height: 12.h),

                  /// ************ dob Field *****************
                  Text(
                    "Date of birth",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "MM/DD/YYYY",
                    controller: _dobController,
                    focusNode: _dobFocusNode,
                  ),

                  SizedBox(height: 25.h),

                  /// ************ Sign up Button *****************
                  KeyedSubtree(
                    key: _signUpButtonKey,
                    child: PrimaryButton(
                      title: "Create account",
                      isLoading: ref
                          .watch(signUpViewModelProvider)
                          .isEmailLoading,
                      onTap: () => _handleRegister(),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// ************ google sign in Button *****************
                  CustomOutlinedButton(
                    title: "Continue with Google",
                    icon: SvgPicture.asset(IconManager.googleIcon),
                    isLoading: ref
                        .watch(signUpViewModelProvider)
                        .isGoogleLoading,
                    onTap: () => handleGoogleLogin(),
                  ),
                  SizedBox(height: 12.h),
                  CustomOutlinedButton(
                    title: "Continue with Apple",
                    icon: SvgPicture.asset(IconManager.appleIcon),
                    isLoading: ref
                        .watch(signUpViewModelProvider)
                        .isAppleLoading,
                    onTap: () => handleAppleLogin(),
                  ),
                  SizedBox(height: 20.h),
                  customDivider(),
                  SizedBox(height: 20.h),

                  /// ************ rich text ******************
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: getRegularStyle14_400(
                          color: ColorManager.brown300,
                        ),
                        children: [
                          TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Sign in",
                            style:
                                getRegularStyle14_500(
                                  color: ColorManager.brown,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.brown,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.signInRoute,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
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
            ),
          ),
        ),

        Expanded(child: Divider(color: ColorManager.brown200, thickness: 2)),
      ],
    );
  }

  //******** Helper Methods**************

  Future<void> _handleRegister() async {
    setState(() {
      _emailError = null;
    });

    final success = await ref
        .read(signUpViewModelProvider.notifier)
        .register(
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text.trim(),
          dob: _dobController.text.trim(),
        );
    print(success);
    if (success && mounted) {
      Navigator.pushReplacementNamed(
        context,
        RoutesName.signupOtpScreen,
        arguments: _emailController.text.trim(),
      );
    } else if (!success && mounted) {
      final state = ref.read(signUpViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? "Registration failed")),
      );
    }
  }

  //***************** Social Login Mixin ***********************
  @override
  bool get isGoogleLoading =>
      ref.read(signUpViewModelProvider).isGoogleLoading;

  @override
  bool get isAppleLoading => ref.read(signUpViewModelProvider).isAppleLoading;

  @override
  String? get errorMessage => ref.read(signUpViewModelProvider).errorMessage;

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

