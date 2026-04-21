import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_from_field.dart';
import '../../../widgets/primary_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        backgroundColor: ColorManager.secondary,
        leading: customBackButton(
          context,
          borderColor: ColorManager.borderColor,
        ),
        title: customLogoText(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forgot Password",
                    style: getBoldStyle24(
                      fontSize: 32.sp,
                      color: ColorManager.brown,
                    ).copyWith(letterSpacing: -0.45),
                  ),
                  SizedBox(height: 15.h),
                  /// ************ Email Field *****************
                  Text(
                    "Email",
                    style: getRegularStyle16_400(
                      color: ColorManager.brown300,
                      fontSize: 14.sp,
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

            /// *************** send btn *******************
            PrimaryButton(
                title: "Send",
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.forgotPasswordOtpRoute);
                }
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }
}