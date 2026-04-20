import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
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
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color inputBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // ====== Back Button & Title ===========
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(IconManager.leftArrowIcon),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Account',
                    style: getBoldStyle24(
                      color: ColorManager.brown,
                    ).copyWith(fontFamily: fontSerif),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.h,
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

              SizedBox(height: 40.h),

              // =========== Form Fields ============
              _buildLabel("Your full name"),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'Yasir Abed Rabbu'),
              SizedBox(height: 20.h),
              CustomFromField(hintText: 'Email address'),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'yasir@gmail.com'),
              SizedBox(height: 20.h),
              CustomFromField(hintText: 'Password'),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'Your password'),
              SizedBox(height: 20.h),
              CustomFromField(hintText: 'Confirm Password'),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'Confirm your password'),
              SizedBox(height: 20.h),
              CustomFromField(hintText: 'Phone number'),
              SizedBox(height: 8.h),
              CustomFromField(hintText: '(123) 456-7890'),
              SizedBox(height: 20.h),
              CustomFromField(hintText: 'Date of birth'),
              SizedBox(height: 8.h),
              CustomFromField(hintText: 'MM/DD/YYYY'),
              SizedBox(height: 40.h),
              // ========== Action Buttons ============
              Row(
                children: [
                  Expanded(child: _buildButton("Cancel", isSecondary: true)),
                  SizedBox(width: 15.w),
                  Expanded(child: _buildButton("Save")),
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
      style: TextStyle(color: mutedBrown, fontSize: 15, fontFamily: fontSerif),
    );
  }

  // ================= Bottom Buttons ==================
  Widget _buildButton(String label, {bool isSecondary = false}) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : darkBrown,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSecondary
                ? BorderSide(color: Colors.black.withOpacity(0.1))
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSecondary ? darkBrown : Colors.white,
            fontSize: 17,
            fontFamily: fontSerif,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
