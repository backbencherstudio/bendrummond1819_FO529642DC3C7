import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSettingsScreen extends ConsumerStatefulWidget {
  const HomeSettingsScreen({super.key});

  @override
  ConsumerState<HomeSettingsScreen> createState() => _HomeSettingsScreenState();
}

class _HomeSettingsScreenState extends ConsumerState<HomeSettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUser();
    });
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return '${months[parsed.month - 1]} ${parsed.year}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =============  Header ================
              Text(
                'Settings',
                style: getRegularStyle16_600(
                  fontSize: 32.sp,

                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),

              // Profile Card
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: ColorManager.brown.withValues(alpha: .5),
                  ),
                ),
                child: Row(
                  children: [
                    // =========  Profile Image ===========
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(
                        'https://wallpapers.com/images/featured/goku-super-saiyan-dm8zixw58guf3x1b.jpg',
                      ),
                    ),
                    SizedBox(width: 15.w),
                    // ========  Profile Info =============
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref.watch(userProvider).user?.name ?? 'User',
                            style: getSemiBoldStyle22(
                              fontSize: 20,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          Text(
                            ref.watch(userProvider).user?.email ?? '',
                            style: getRegularStyle16_400(
                              color: ColorManager.brown300,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            ref.watch(userProvider).user != null
                                ? 'Member since ${_formatDate(ref.watch(userProvider).user!.createdAt)}'
                                : '',
                            style: getRegularStyle16_400(
                              color: ColorManager.brown300,
                              fontSize: 12,
                            ),
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

              SizedBox(height: 16.h),

              // Bottom Action Buttons
              Row(
                children: [
                  // Delete Button
                  Expanded(
                    child: _buildActionButton(
                      onTap: () {},
                      label: "Account Delete",
                      icon: IconManager.deleteIcon,
                      color: ColorManager.redColor, // Red
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Sign out Button
                  Expanded(
                    child: _buildActionButton(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signInRoute);
                      },
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.backgroundPressed100),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.h),
            SizedBox(width: 8.w),
            Text(
              title,
              style: getMediumStyle18(
                color: ColorManager.brown400,
                fontSize: 16,
              ),
            ),
            Spacer(),
            SvgPicture.asset(IconManager.arrowIcon, width: 20.w, height: 20.h),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Bottom Action Buttons
  Widget _buildActionButton({
    required String label,
    required String icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, width: 20.w, height: 20.h),
              SizedBox(width: 4.w),
              Text(
                label,
                style: getMediumStyle18(color: textColor, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
