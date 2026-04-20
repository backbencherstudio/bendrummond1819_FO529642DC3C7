import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/image_manager.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/primary_button.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key});

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                      padding: EdgeInsets.only(left: 24.w, top: 20.h),
                      child: Text(
                        "STABILITY",
                        style: getRegularStyle16_400(
                          fontSize: 20.sp,
                          color: ColorManager.brown500,
                        ).copyWith(letterSpacing: 6),
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
                    "Welcome back",
                    style: getBoldStyle24(
                      fontSize: 32.sp,
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
                    style: getRegularStyle16_400(
                      color: ColorManager.brown300,
                      fontSize: 14.sp,
                    ),
                  ),
                  /// ************ Email Field *****************
                  CustomFromField(
                    hintText: "you@example.com",
                    controller: _emailController,
                  ),

                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password",
                        style: getRegularStyle16_400(
                          color: ColorManager.brown300,
                          fontSize: 14.sp,
                        ),
                      ),
                      /// ************ Forgot password Button *****************
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password?",
                          style:
                              getRegularStyle16_500(
                                color: ColorManager.brown,
                                fontSize: 14.sp,
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
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorManager.brown,
                    ),
                  ),

                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "Forgot password?",
                  //       style: getRegularStyle16_500(color: ColorManager.brown)
                  //           .copyWith(
                  //             decoration: TextDecoration.underline,
                  //             decorationColor: ColorManager.brown,
                  //           ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 25.h),

                  /// ************ Sign in Button *****************
                  PrimaryButton(title: "Sign In", onTap: () {}),

                  SizedBox(height: 12.h),

                  /// ************ google sign in Button *****************
                  CustomOutlinedButton(
                    title: "Continue with Google",
                    icon: SvgPicture.asset(IconManager.googleIcon),
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signInRoute);
                    },
                  ),
                  SizedBox(height: 20.h),
                  customDivider(),
                  SizedBox(height: 20.h),

                  /// ************ rich text ******************
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: getRegularStyle16_400(
                          color: ColorManager.brown300,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(text: "New to stability? "),
                          TextSpan(
                            text: "Create an account.",
                            style:
                                getRegularStyle16_500(
                                  color: ColorManager.brown,
                                  fontSize: 14.sp,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.brown,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, RoutesName.signUpRoute);
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
