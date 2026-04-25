import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpScreen extends StatefulWidget {
  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 32.r),
          child: Column(
            children: [
              Row(
                spacing: 12.w,
                children: [
                  customBackButton(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.h,
                    children: [
                      Text(
                        "data",
                        style: getRegularStyle16_400(
                          color: ColorManager.brown400,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.r),
                          border: Border.all(color: ColorManager.borderColor2),
                        ),
                        height: 8.h,
                        width: 270.w,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(99.r),
                          backgroundColor: ColorManager.secondaryBackGround,
                          value: .7,
                          valueColor: AlwaysStoppedAnimation(
                            ColorManager.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
