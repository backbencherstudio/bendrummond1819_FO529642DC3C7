import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
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
        title: Text(
          "STABILITY",
          style: getRegularStyle16_500(color: ColorManager.brown).copyWith(
            fontFamily: "Montserrat",
            letterSpacing: 4,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: getBoldStyle24(
                fontSize: 32.sp,
                color: ColorManager.brown,
              ).copyWith(height: 1.1, letterSpacing: -0.5),
            ),
            SizedBox(height: 15.h),
            Text(
              "Email",
              style: getRegularStyle16_400(
                color: ColorManager.brown300,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 10.h),

            /// ************ Email Field *****************
            CustomFromField(
              hintText: "you@example.com",
              //controller: _emailController,
            ),

            SizedBox(height: 12.h),

            /// ************ Sign in Button *****************
            //Spacer()
            PrimaryButton(title: "Send", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
