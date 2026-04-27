import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/color_manger.dart';
import '../../../../core/resource/constants/style_manager.dart';
import '../../../../core/route/routes_name.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_from_field.dart';
import '../../../widgets/custom_logo_text.dart';
import '../../../widgets/primary_button.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
                    "Set New Password",
                    style: getBoldStyle32(
                      color: ColorManager.brown,
                    ).copyWith(letterSpacing: -0.45),
                  ),
                  SizedBox(height: 15.h),

                  /// ************ password Field *****************
                  Text(
                    "Password",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 10.h),
                  CustomFromField(
                    hintText: "Enter your password",
                    controller: _passwordController,
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorManager.brown500,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  /// ************ confirm password Field *****************
                  Text(
                    "Confirm Password",
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                  SizedBox(height: 10.h),
                  CustomFromField(
                    hintText: "Confirm your password",
                    controller: _confirmPasswordController,
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorManager.brown500,
                    ),
                  ),
                ],
              ),
            ),

            /// *************** send btn *******************
            PrimaryButton(
              title: "Update Password",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.signInRoute);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
