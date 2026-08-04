import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signin/view/cutom_divider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/network/api_clients.dart';
import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/image_manager.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../../data/repositories/setup_repository.dart';
import '../../../../data/sources/remote/setup_api_service.dart';
import '../../../mixins/keyboard_aware_header.dart';
import '../../../mixins/keyboard_aware_scroll_mixin.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/primary_button.dart';
import '../../mixins/social_login_mixin.dart';
import '../viewmodel/signin_viewmodel.dart';

class SigningScreen extends ConsumerStatefulWidget {
  const SigningScreen({super.key});

  @override
  ConsumerState<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends ConsumerState<SigningScreen>
    with KeyboardAwareScrollMixin, SocialLoginMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInButtonKey = GlobalKey();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    registerAutoScrollFocus(_emailFocusNode, _signInButtonKey);
    registerAutoScrollFocus(_passwordFocusNode, _signInButtonKey);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInState =
        ref.watch(signInViewModelProvider).value ??
        const SignInState(
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
                    "Welcome back",
                    style: getBoldStyle32(
                      color: ColorManager.brown,
                    ).copyWith(height: 1.1, letterSpacing: -0.5),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "Access your personalized financial clarity dashboard.",
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),

                  SizedBox(height: 25.h),
                  Text(
                    "Email",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 12.h),

                  /// ************ Email Field *****************
                  CustomFromField(
                    hintText: "you@example.com",
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                  ),

                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password",
                        style: getRegularStyle14_400(
                          color: ColorManager.brown300,
                        ),
                      ),

                      /// ************ Forgot password Button *****************
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.forgotPasswordRoute,
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style:
                              getRegularStyle14_500(
                                color: ColorManager.brown500,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.brown,
                              ),
                        ),
                      ),
                    ],
                  ),

                  /// ***************** password field ****************
                  CustomFromField(
                    hintText: "Your password",
                    controller: _passwordController,
                    isSecured: true,
                    focusNode: _passwordFocusNode,
                  ),

                  SizedBox(height: 25.h),

                  /// ************ Sign in Button *****************
                  KeyedSubtree(
                    key: _signInButtonKey,
                    child: PrimaryButton(
                      title: "Sign In",
                      isLoading: signInState.isEmailLoading,
                      onTap: () => handleCredentialsSignIn(),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// ************ google sign in Button *****************
                  CustomOutlinedButton(
                    title: "Continue with Google",
                    icon: SvgPicture.asset(IconManager.googleIcon),
                    isLoading: signInState.isGoogleLoading,
                    onTap: () => handleGoogleLogin(),
                  ),

                  SizedBox(height: 16.h),
                  CustomOutlinedButton(
                    title: "Continue with Apple",
                    icon: SvgPicture.asset(IconManager.appleIcon),
                    isLoading: signInState.isAppleLoading,
                    onTap: () => handleAppleLogin(),
                  ),
                  SizedBox(height: 10.h),
                  CustomDivider(),
                  SizedBox(height: 10.h),

                  /// ************ rich text ******************
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: getRegularStyle14_400(
                          color: ColorManager.brown300,
                        ),
                        children: [
                          TextSpan(text: "New to Stability? "),
                          TextSpan(
                            text: "Create an account.",
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
                                  RoutesName.signUpRoute,
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

  //***************** Helper Methods***********************
  Future<void> handleCredentialsSignIn() async {
    final success = await ref
        .read(signInViewModelProvider.notifier)
        .signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (success && mounted) {
      await _onSignInSuccess();
    } else if (mounted) {
      final state = ref.read(signInViewModelProvider).value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state?.errorMessage ?? "Login failed")),
      );
    }
  }

  //***************** Social Login Mixin ***********************
  @override
  bool get isGoogleLoading =>
      ref.read(signInViewModelProvider).value?.isGoogleLoading ?? false;

  @override
  bool get isAppleLoading =>
      ref.read(signInViewModelProvider).value?.isAppleLoading ?? false;

  @override
  String? get errorMessage =>
      ref.read(signInViewModelProvider).value?.errorMessage;

  @override
  Future<bool> googleSignIn() async {
    return ref.read(signInViewModelProvider.notifier).googleSignIn();
  }

  @override
  Future<bool> appleSignIn() async {
    return ref.read(signInViewModelProvider.notifier).appleSignIn();
  }

  @override
  void onSocialLoginSuccess() {
    _onSignInSuccess();
  }

  Future<void> _onSignInSuccess() async {
    final setupComplete = await _isSetupComplete();
    if (!mounted) return;
    if (setupComplete == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.bottomNavRoute,
        (route) => false,
      );
    } else if (setupComplete == false) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.setUpScreen,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to verify account status. Please try again later.",
          ),
        ),
      );
    }
  }

  Future<bool?> _isSetupComplete() async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final data = await repository.getSetupData();
      if (data == null) return false;
      return data.incomes.isNotEmpty ||
          data.financialCommitments.isNotEmpty ||
          data.savingsGoals.isNotEmpty;
    } catch (_) {
      return null;
    }
  }
}
