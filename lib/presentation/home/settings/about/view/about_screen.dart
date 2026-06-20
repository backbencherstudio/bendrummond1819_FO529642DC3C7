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
                    borderColor: ColorManager.backgroundPressed100,
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
                onTap: _showTermsOfService,
              ),
              SizedBox(height: 16),
              _buildAboutTile(
                "Privacy Policy",
                trailing: Icon(Icons.chevron_right, color: ColorManager.brown),
                onTap: _showPrivacyPolicy,
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

  void _showTermsOfService() {
    _showContent(
      title: "Terms of Service",
      body:
          "These Terms of Service govern your use of our application. By using Stability, "
          "you agree to these terms. Please read them carefully.\n\n"
          "1. Acceptance of Terms\n"
          "By accessing and using this application, you accept and agree to be bound by "
          "the terms and conditions of this agreement.\n\n"
          "2. User Responsibilities\n"
          "You are responsible for maintaining the confidentiality of your account and "
          "password and for restricting access to your account.\n\n"
          "3. Privacy\n"
          "Your use of the application is also governed by our Privacy Policy.\n\n"
          "4. Modifications\n"
          "We reserve the right to modify these terms at any time. Changes will be "
          "effective immediately upon posting.\n\n"
          "5. Contact\n"
          "For questions about these terms, please contact support@stability.app",
    );
  }

  void _showPrivacyPolicy() {
    _showContent(
      title: "Privacy Policy",
      body:
          "Your privacy is important to us. This Privacy Policy explains how we collect, "
          "use, and protect your personal information.\n\n"
          "1. Information We Collect\n"
          "We collect information you provide directly, such as your name, email address, "
          "and financial data necessary for the app's functionality.\n\n"
          "2. How We Use Your Information\n"
          "We use your information to provide, maintain, and improve our services, "
          "including personal financial insights and bill management.\n\n"
          "3. Data Security\n"
          "We implement appropriate security measures to protect your personal information "
          "from unauthorized access or disclosure.\n\n"
          "4. Third-Party Services\n"
          "We do not share your personal information with third parties except as "
          "necessary to provide our services.\n\n"
          "5. Changes to This Policy\n"
          "We may update this policy from time to time. We will notify you of any "
          "changes by posting the new policy on this page.\n\n"
          "6. Contact\n"
          "For questions about this policy, please contact support@stability.app",
    );
  }

  void _showContent({required String title, required String body}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldStyle32(color: ColorManager.brown),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    body,
                    style:
                        getRegularStyle16_400(color: ColorManager.brown400),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Close",
                        style: getMediumStyle18(color: ColorManager.brown),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Widget for the About rows
  Widget _buildAboutTile(String title,
      {required Widget trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              style:
                  getMediumStyle18(color: ColorManager.c201F2E, fontSize: 16),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
