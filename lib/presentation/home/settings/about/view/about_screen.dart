import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Back Button + Title
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.borderColor2,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'About',
                    style: getSemiBoldStyle22(
                      color: ColorManager.textPrimary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Menu Options
              _buildAboutTile(
                "Terms of Service",
                trailing: Icon(Icons.chevron_right, color: ColorManager.brown),
              ),
              SizedBox(height: 16),
              _buildAboutTile(
                "Privacy Policy",
                trailing: Icon(Icons.chevron_right, color: ColorManager.brown),
              ),
              const SizedBox(height: 16),
              _buildAboutTile(
                "App Version",
                trailing: Text(
                  "1.0.0",
                  style: getRegularStyle16_400(color: ColorManager.brown300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for the About rows
  Widget _buildAboutTile(String title, {required Widget trailing}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorManager.brown.withValues(alpha: .5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getMediumStyle18(color: ColorManager.c201F2E, fontSize: 16),
          ),
          trailing,
        ],
      ),
    );
  }
}
