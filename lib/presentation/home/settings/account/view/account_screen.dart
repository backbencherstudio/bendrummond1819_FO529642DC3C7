import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== Back Button & Title ===========
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.borderColor2,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Account',
                    style: getSemiBoldStyle22(
                      color: ColorManager.brown,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.whiteColor,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://wallpapers.com/images/featured/goku-background-vhm3f71ddueli0kl.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: ColorManager.brown,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorManager.black400,
                            width: 2,
                          ),
                        ),
                        child: SvgPicture.asset(IconManager.editIcon),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // =========== Form Fields ============
              _buildLabel("Your full name"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: 'Yasir Abed Rabbu'),
              SizedBox(height: 12.h),

              _buildLabel("Email address"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: 'yasir@gmail.com'),
              SizedBox(height: 12.h),

              _buildLabel("Password"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: 'Your Password',
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),

              SizedBox(height: 12.h),
              _buildLabel("Confirm Password"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: 'Confirm your password',
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),

              SizedBox(height: 12.h),
              _buildLabel("Phone number"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: '(123) 456-7890'),
              SizedBox(height: 12.h),
              _buildLabel("Date of birth"),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'MM/DD/YYYY'),
              SizedBox(height: 32.h),
              // ========== Action Buttons ============
              Row(
                children: [
                  Expanded(child: _buildButton("Cancel",(){} , isSecondary: true)),
                  SizedBox(width: 15.w),
                  Expanded(child: _buildButton("Save",(){},)),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: Section Labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  // ================= Bottom Buttons ==================
  Widget _buildButton(String label, VoidCallback onTap, {bool isSecondary = false}) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : ColorManager.brown,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: isSecondary
                ? BorderSide(color: ColorManager.borderColor2)
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: getMediumStyle18(color: isSecondary ?  ColorManager.brown : Colors.white,fontSize: 16)
        ),
      ),
    );
  }
}
