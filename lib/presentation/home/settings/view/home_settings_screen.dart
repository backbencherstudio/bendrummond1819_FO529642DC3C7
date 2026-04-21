import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSettingsScreen extends StatefulWidget {
  const HomeSettingsScreen({super.key});

  @override
  State<HomeSettingsScreen> createState() => _HomeSettingsScreenState();
}

class _HomeSettingsScreenState extends State<HomeSettingsScreen> {
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
              SizedBox(height: 40.h),
              // =============  Header ================
              Text(
                'Settings',
                style: getRegularStyle16_600(
                  fontSize: 32.sp,
               
                  color: ColorManager.brown,
                ),
              ),
              SizedBox(height: 25.h),

              // Profile Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: ColorManager.brown.withValues(alpha: .5),
                  ),
                ),
                child: Row(
                  children: [
                    // =========  Profile Image ===========
                    CircleAvatar(
                      radius: 35.r,
                      backgroundImage: NetworkImage(
                        'https://wallpapers.com/images/featured/goku-super-saiyan-dm8zixw58guf3x1b.jpg', // Placeholder for Yasir
                      ),
                    ),
                    SizedBox(width: 15.w),
                    // ========  Profile Info =============
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yasir Abed Rabbu',
                            style: getRegularStyle20_500(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.brown,
                            ).copyWith(fontFamily: fontSerif),
                          ),
                          Text(
                            'yasirabedrabbu@gmail.com',
                            style: getLightStyle14_400(
                              fontSize: 14,
                              color: ColorManager.brown,
                            ).copyWith(fontFamily: fontSerif),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Member since January 2024',
                            style: getLightStyle12_400(
                              color: ColorManager.brown300,
                            ).copyWith(fontFamily: fontSerif),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Menu Items
              _buildMenuTile(IconManager.userIcon, "Account", () {
                Navigator.pushNamed(context, RoutesName.accountScreen);
              }),
              SizedBox(height: 15.h),
              _buildMenuTile(IconManager.notificationIcon, "Notifications", () {
                Navigator.pushNamed(context, RoutesName.notificationScreen);
              }),
              SizedBox(height: 15.h),
              _buildMenuTile(IconManager.aboutIcon, "About", () {
                Navigator.pushNamed(context, RoutesName.aboutScreen);
              }),

              SizedBox(height: 30.h),

              // Bottom Action Buttons
              Row(
                children: [
                  // Delete Button
                  Expanded(
                    child: _buildActionButton(
                      label: "Account Delete",
                      icon: IconManager.deleteIcon,
                      color: ColorManager.redColor, // Red
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Sign out Button
                  Expanded(
                    child: _buildActionButton(
                      label: "Sign out",
                      icon: IconManager.exitIcon,
                      color: ColorManager.greyColor, // Grey
                      textColor: ColorManager.brown,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Menu Tiles
  Widget _buildMenuTile(String icon, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.containerColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        leading: SvgPicture.asset(icon, width: 20.w, height: 20.h),
        title: Text(
          title,
          style: getRegularStyle16_500(
            color: ColorManager.brown.withValues(alpha: 0.8),
          ),
        ),
        trailing: SvgPicture.asset(
          IconManager.arrowIcon,
          width: 20.w,
          height: 20.h,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        onTap: onTap,
      ),
    );
  }

  // Helper Widget for Bottom Action Buttons
  Widget _buildActionButton({
    required String label,
    required String icon,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, width: 20.w, height: 20.h),
              SizedBox(width: 10.w),
              Text(
                label,
                style: getRegularStyle16_500(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ).copyWith(fontFamily: fontSerif),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
