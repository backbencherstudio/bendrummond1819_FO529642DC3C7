import 'package:bendrummond1819_fo529642dc3c7/presentation/mixins/keyboard_aware_scroll_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/resource/utils.dart';
import '../../../../core/route/routes_name.dart';
import '../../../../data/repositories/setup_repository.dart';
import '../../../../data/sources/remote/setup_api_service.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_headline.dart';
import '../../widgets/auth_switch_link.dart';
import '../../widgets/labeled_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../../mixins/social_login_mixin.dart';
import '../../widgets/social_login_buttons.dart';
import '../viewmodel/signin_viewmodel.dart';
import '../widgets/cutom_divider.dart';

class SigningScreen extends ConsumerStatefulWidget {
  const SigningScreen({super.key});

  @override
  ConsumerState<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends ConsumerState<SigningScreen>
    with KeyboardAwareScrollMixin, SocialLoginMixin {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInButtonKey = GlobalKey();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String _selectedPhoneCode = '1';

  @override
  void initState() {
    super.initState();
    // Native flutter resizeToAvoidBottomInset handles it
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
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
            const AuthHeader(),
            Container(
              width: double.infinity,
              color: ColorManager.cF0EBE3,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  AuthHeadline(
                    title: "Welcome back",
                    subtitle:
                        "Access your personalized financial clarity dashboard.",
                    titleStyle: getBoldStyle32(
                      color: ColorManager.brown,
                    ).copyWith(height: 1.1, letterSpacing: -0.5),
                  ),

                  SizedBox(height: 25.h),

                  LabeledFormField(
                    label: "Phone number",
                    hintText: "(123) 456-7890",
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    prefix: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          showDragHandle: false,
                          countryListTheme: CountryListThemeData(
                            bottomSheetHeight:
                                MediaQuery.of(context).size.height * 0.66,
                            textStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                            searchTextStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 0.h,
                            ),
                            margin: EdgeInsets.zero,
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              _selectedPhoneCode = country.phoneCode;
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: ColorManager.brown400,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '+$_selectedPhoneCode',
                                  style: getRegularStyle16_400(
                                    color: ColorManager.brown400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  LabeledFormField(
                    label: "Password",
                    hintText: "Your password",
                    controller: _passwordController,
                    isSecured: true,
                    focusNode: _passwordFocusNode,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.forgotPasswordRoute,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(top: 8.h),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style:
                            getRegularStyle14_500(
                              color: ColorManager.brown500,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorManager.brown,
                            ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  KeyedSubtree(
                    key: _signInButtonKey,
                    child: PrimaryButton(
                      title: "Sign In",
                      isLoading: signInState.isEmailLoading,
                      onTap: () => handleCredentialsSignIn(),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  SocialLoginButtons(
                    isGoogleLoading: signInState.isGoogleLoading,
                    onGoogleTap: () => handleGoogleLogin(),
                    isAppleLoading: signInState.isAppleLoading,
                    onAppleTap: () => handleAppleLogin(),
                  ),

                  SizedBox(height: 10.h),
                  const CustomDivider(),
                  SizedBox(height: 10.h),

                  AuthSwitchLink(
                    leadingText: "New to Stability? ",
                    linkText: "Create an account.",
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.signUpRoute),
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
          phone: '+$_selectedPhoneCode${_phoneController.text.trim()}',
          password: _passwordController.text,
        );

    if (success && mounted) {
      await _onSignInSuccess();
    } else if (mounted) {
      final state = ref.read(signInViewModelProvider).value;
      Utils.showErrorToast(message: state?.errorMessage ?? "Login failed");
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
      Navigator.pushReplacementNamed(context, RoutesName.setUpScreen);
    } else {
      Utils.showErrorToast(
        message: "Unable to verify account status. Please try again later.",
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
