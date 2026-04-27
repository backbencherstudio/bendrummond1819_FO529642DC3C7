import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/icon_manager.dart';
import '../../../../core/resource/constants/image_manager.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_from_field.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageSectionHeight = screenHeight * 0.58;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: imageSectionHeight,
              width: double.infinity,
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
                      padding: EdgeInsets.all(8.h),
                      child: Row(
                        children: [customBackButton(context), customLogoText()],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              color: ColorManager.secondary,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),

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
                    style: getRegularStyle14_400(
                      color: ColorManager.brown300,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomFromField(
                    hintText: "What should we call you?",
                    controller: _fullNameController,
                  ),

                  SizedBox(height: 12.h),

                  /// ************ email Field *****************
                  Text(
                    "Email address",
                    style: getRegularStyle14_400(
                      color: ColorManager.brown300,
                    ),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "you@example.com",
                    controller: _emailController,
                  ),

                  SizedBox(height: 12.h),

                  /// ***************** password field ****************
                  Text(
                    "Password",
                    style: getRegularStyle14_400(
                      color: ColorManager.brown300,
                    ),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "Your password",
                    controller: _passwordController,
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorManager.brown,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// ************ phone Field *****************
                  Text(
                    "Phone number",
                    style: getRegularStyle14_400(
                      color: ColorManager.brown300,
                    ),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "(123) 456-7890",
                    controller: _phoneController,
                  ),

                  SizedBox(height: 12.h),

                  /// ************ dob Field *****************
                  Text(
                    "Date of birth",
                    style: getRegularStyle14_400(
                      color: ColorManager.brown300,
                    ),
                  ),
                  SizedBox(height: 5.h),

                  CustomFromField(
                    hintText: "MM/DD/YYYY",
                    controller: _dobController,
                  ),

                  SizedBox(height: 25.h),

                  /// ************ Sign in Button *****************
                  PrimaryButton(
                    title: "Create account",
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signupOtpScreen);
                    },
                  ),

                  SizedBox(height: 12.h),

                  /// ************ google sign in Button *****************
                  CustomOutlinedButton(
                    title: "Continue with Google",
                    icon: SvgPicture.asset(IconManager.googleIcon),
                    onTap: () {
                      /// google sign in
                    },
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
                  SizedBox(height: 20.h),
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
              //shape: BoxShape.circle,
            ),
          ),
        ),

        Expanded(child: Divider(color: ColorManager.brown200, thickness: 2)),
      ],
    );
  }
}
